OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  oauth_yaml = YAML.load_file('.google-api.yaml')
  provider :google_oauth2, oauth_yaml["client_id"], oauth_yaml["client_secret"], {access_type:'offline',
  scope:'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
  redirect_uri:'http://localhost:3000/auth/google_oauth2/callback'
  }
end
