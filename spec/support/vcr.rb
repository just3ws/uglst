VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = { record: :new_episodes }
  c.allow_http_connections_when_no_cassette = false
  c.configure_rspec_metadata!

  c.ignore_hosts 'codeclimate.com'

  filters = []

  # Github
  filters += %w(GITHUB_ADMIN_USER_PASSWORD GITHUB_CLIENT_ID GITHUB_SECRET)

  # LinkedIn
  filters += %w(LINKEDIN_KEY LINKEDIN_SECRET)

  # Mailgun
  filters += %w(MAILGUN_API_KEY MAILGUN_TOKEN)

  # Mixpanel
  filters += %w(MIXPANEL_API_SECRET MIXPANEL_TOKEN)

  # Twitter
  filters += %w(TWITTER_ACCOUNT_ID TWITTER_CONSUMER_KEY TWITTER_CONSUMER_SECRET TWITTER_OAUTH_SECRET TWITTER_OAUTH_TOKEN)
  filters += %w(TWITTER_ACCESS_TOKEN TWITTER_ACCESS_TOKEN_SECRET TWITTER_API_KEY TWITTER_API_SECRET TWITTER_OWNER TWITTER_OWNER_ID)

  # Stripe
  filters += %w(STRIPE_PUBLISHABLE_KEY STRIPE_SECRET_KEY)

  # Akismet
  filters += %w(AKISMET_KEY)


  filters.each do |filter|
    c.filter_sensitive_data("<#{filter}>") { ENV[filter] }
  end

  #c.filter_sensitive_data("<AUTHORIZATION>") do |interaction|
    ##interaction.request.headers['Authorization'].each do |str|
    ##puts str
    ##end
    #ENV[
      #"OAuth" #  oauth_consumer_key=\"iH6XpKwEIRjPP0wKdzrLyvxwk\", oauth_nonce=\"46f52976667993e0f9709419a315f3b6\", oauth_signature=\"E0yz%2Ba9BhtlqG%2BwNUJugbhKuFCc%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1409975081\", oauth_token=\"450382927-GSd5vpql8gUdlkFboKFoMdNQ2Ndz5bScxP3qofgv\", oauth_version=\"1.0\""
  #end
end

