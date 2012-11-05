class SessionsController < ApplicationController

  require 'rubygems'
  require 'google/api_client'
  require 'yaml'

  def create
    #What data comes back from OmniAuth?
    @auth = request.env["omniauth.auth"]
    #Use the token from the data to request a list of calendars
    @token = @auth["credentials"]["token"]
    client = Google::APIClient.new
    client.authorization.access_token = @token
    service = client.discovered_api('calendar', 'v3')
    start_min=Date.today.at_beginning_of_month.to_datetime.to_formatted_s
    start_max=Date.today.at_end_of_month.to_datetime.to_formatted_s
   time_min='2012-10-01T00:00:00+00:00'
    time_max='2012-10-31T00:00:00+00:00'
    @result = client.execute(
    :api_method => service.events.list,
    :parameters => {:calendarId => 'webmaster@massanuttenlions.com',:singleEvents=>'true'},
    :headers => {'Content-Type' => 'application/json'}
    )





  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
