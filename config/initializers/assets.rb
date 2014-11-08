Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

Rails.application.config.assets.precompile += %w(
  user_groups.js
  pages.js
  sessions.js
  profiles.js
  registrations.js
  networks.js
)
