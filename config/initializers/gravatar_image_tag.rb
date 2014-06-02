# config/initializers/gravatar_image_tag.rb
GravatarImageTag.configure do |config|
  config.default_image = :identicon
  config.secure                  = true # Set this to true if you require secure images on your pages.
end
