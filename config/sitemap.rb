SitemapGenerator::Sitemap.default_host  = 'https://ugl.st'
SitemapGenerator::Sitemap.sitemaps_host = "http://uglst-#{Rails.env}.s3.amazonaws.com/"
SitemapGenerator::Sitemap.public_path   = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter       = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  UserGroup.find_each do |ug|
    add user_groups_path(ug)
  end

  User.find_each do |user|
    add profile_path(user)
  end
end
