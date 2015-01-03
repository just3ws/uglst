Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

Rails.application.config.assets.precompile += %w(
  account.css
  account.js
  happy.css
  happy.js
  happy/hello.css
  happy/hello.js
  networks.css
  networks.js
  pages.css
  pages.js
  personal.css
  personal.js
  profiles.css
  profiles.js
  public.css
  public.js
  registrations.css
  registrations.js
  sessions.css
  sessions.js
  user_groups.css
  user_groups.js
)
