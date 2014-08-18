require 'dotenv'
Dotenv.load

group :livereload do
  guard 'livereload' do
    watch(%r{app/views/.+\.(erb|haml|slim)$})
    watch(%r{app/helpers/.+\.rb})
    watch(%r{public/.+\.(css|js|html)})
    watch(%r{config/locales/.+\.yml})
    # Rails Assets Pipeline
    watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
  end
end

group :rspec, halt_on_fail: true do
  guard :rspec, failed_mode: :keep, all_on_start: true, all_after_pass: true, cmd: 'bundle exec rspec spec' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb') { 'spec' }
    watch('config/routes.rb') { 'spec' }

    # Rails example
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/features/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
    watch('config/routes.rb') { 'spec/routing' }
    watch('app/controllers/application_controller.rb') { 'spec/controllers' }

    # Capybara features specs
    watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$}) { |m| "spec/features/#{m[1]}_spec.rb" }

    # Capyfeatures and steps
    watch(%r{^spec/features/(.+)\.feature$})
    watch(%r{^spec/features/steps/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/features' }
  end
end
