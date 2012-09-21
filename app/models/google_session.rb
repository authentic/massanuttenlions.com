class GoogleSession < ActiveRecord::Base
  require 'rubygems'
  require 'google/api_client'
  require 'yaml'
  require 'data_mapper'
  require 'logger'
  enable :sessions
  DataMapper.setup(:default, 'mysql://olgahauze:gideon@hostname/massanuttenlions_development')
  include DataMapper::Resource

  property :id, Serial
  property :refresh_token, String, :length => 255
  property :access_token, String, :length => 255
  property :expires_in, Integer
  property :issued_at, Integer

  def update_token!(object)
    self.refresh_token = object.refresh_token
    self.access_token = object.access_token
    self.expires_in = object.expires_in
    self.issued_at = object.issued_at
  end

  def to_hash
    return {
        :refresh_token => refresh_token,
        :access_token => access_token,
        :expires_in => expires_in,
        :issued_at => Time.at(issued_at)
    }
  end

  GoogleSession.auto_migrate!


  def save_token_pair(session, client)
    token_pair = if session[:token_id]
                   GoogleSession.first_or_create(:id => session[:token_id])
                 else
                   GoogleSession.new
                 end
    token_pair.update_token!(client.authorization)
    if token_pair.save
      session[:token_id] = token_pair.id
    else
      token_pair.errors.each do |e|
        raise e
      end
    end
  end


  def configure
    log_file = File.open('log/calendar.log', 'a+')
    log_file.sync = true
    logger = Logger.new(log_file)
    logger.level = Logger::DEBUG
    set :logger, logger
  end

  def logger;
    settings.logger;
  end

  before do
    oauth_yaml = YAML.load_file('.google-api.yaml')
    @client = Google::APIClient.new
    @client.authorization.client_id = oauth_yaml["client_id"]
    @client.authorization.client_secret = oauth_yaml["client_secret"]
    @client.authorization.scope = oauth_yaml["scope"]
    @client.authorization.refresh_token = oauth_yaml["refresh_token"]
    @client.authorization.access_token = oauth_yaml["access_token"]
    @client.authorization.redirect_uri = to('/oauth2callback')
    @client.authorization.code = params[:code] if params[:code]
    logger.debug session.inspect
    if session[:token_id]
      # Load the access token here if it's available
      token_pair = GoogleSession.get(session[:token_id])
      @client.authorization.update_token!(token_pair.to_hash)
    end
    if @client.authorization.refresh_token && @client.authorization.expired?
      @client.authorization.fetch_access_token!
    end
    @calendar = @client.discovered_api('calendar', 'v3')
    unless @client.authorization.access_token || request.path_info =~ /^\/oauth2/
      redirect_to('/oauth2authorize')
    end
  end

  get '/oauth2authorize' do
    redirect @client.authorization.authorization_uri.to_s, 303
  end

  get '/oauth2callback' do
    @client.authorization.fetch_access_token!
    # Persist the token here
    token_pair = if session[:token_id]
                   GoogleSession.get(session[:token_id])
                 else
                   GoogleSession.new
                 end
    token_pair.update_token!(@client.authorization)
    token_pair.save
    session[:token_id] = token_pair.id
    redirect to('/')
  end

  get '/' do
    result = @client.execute(:api_method => @calendar.events.list,
                             :parameters => {'calendarId' => 'webmaster@massanuttenlions.com'})
    status, _, _ = result.response
    [status, {'Content-Type' => 'application/json'}, result.data.to_json]
  end


  while true
    events = result.data.items
    events.each do |e|
      print e.summary + "\n"
    end
    if !(page_token = result.data.next_page_token)
      break
    end
    result = @client.execute(:api_method => service.events.list,
                             :parameters => {'calendarId' => 'lg28rdifqmjumld23fq8rka1eo@group.calendar.google.com', 'pageToken' => page_token, 'timeMax' => 'timeMax', 'timeMin' => 'timeMin'})
  end


  DataMapper.finalize


end
