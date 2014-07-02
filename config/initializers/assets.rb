Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

Rails.application.config.assets.precompile += %w( user_groups.js )
Rails.application.config.assets.precompile += %w( sessions.js )
Rails.application.config.assets.precompile += %w( profiles.js )
Rails.application.config.assets.precompile += %w( registrations.js )
