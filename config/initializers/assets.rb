Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

Rails.application.config.assets.precompile += %w(
  user_groups.js
  pages.js
  sessions.js
  profiles.js
  registrations.js
  networks.js
)
