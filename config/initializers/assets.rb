Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

Rails.application.config.assets.precompile += %w(
  happy.css
  happy.js
  happy/hello.js
  networks.js
  pages.js
  personal.js
  profiles.js
  public.js
  registrations.js
  sessions.js
  user_groups.js
)
