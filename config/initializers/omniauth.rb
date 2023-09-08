Rails.application.config.middleware.use OmniAuth::Builder do
  # vars stored in .env file in development, exported as env vars in prod
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    {
      scope: 'userinfo.email, userinfo.profile',
      skip_jwt: true
    }
end
OmniAuth.config.allowed_request_methods = %i[get]
