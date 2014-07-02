xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'User-Group List'
    xml.title 'Connecting user-group organizers with the members of their community and the sponsors who help fund them.'
    xml.link user_groups_url
    for ug in @user_groups
      xml.item do
        xml.title ug.name
        xml.description ug.description
        xml.pubDate ug.created_at.to_s(:rfc822)
        xml.link user_groups_url(ug)
        xml.guid user_groups_url(ug)
      end
    end
  end
end
