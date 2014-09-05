xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
    xml.channel do
        xml.title 'User-Group List'
        xml.title 'Connecting user-group organizers with the members of their community and the sponsors who help fund them.'
        xml.link user_groups_url
        for user_group in @user_groups
            xml.item do
                xml.title user_group.name
                xml.description user_group.description
                xml.pubDate user_group.created_at.to_s(:rfc822)
                xml.link user_group_url(user_group)
                xml.guid user_group_url(user_group)
            end
        end
    end
end
