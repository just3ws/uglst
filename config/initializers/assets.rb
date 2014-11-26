Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

Rails.application.config.assets.precompile += %w(
  confirmations.js
  networks.js
  pages.js
  profiles.js
  registrations.js
  sessions.js
  user_groups.js
)
