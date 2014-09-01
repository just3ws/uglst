SitemapGenerator::Sitemap.default_host = 'https://ugl.st'
SitemapGenerator::Sitemap.create_index = false

SitemapGenerator::Sitemap.create do
  UserGroup.find_each do |ug|
    add user_group_path(ug)
  end

  User.find_each do |user|
    add profile_path(user)
  end
end
