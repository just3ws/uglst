xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0' do
  xml.channel do
    xml.title 'User-Group List - Networks'
    xml.title 'Connecting user-group organizers with the members of their community and the sponsors who help fund them.'
    xml.link networks_url
    for network in @networks
      xml.item do
        xml.title network.name
        xml.description network.description
        xml.pubDate network.created_at.to_s(:rfc822)
        xml.link network_url(network)
        xml.guid network_url(network)
      end
    end
  end
end
