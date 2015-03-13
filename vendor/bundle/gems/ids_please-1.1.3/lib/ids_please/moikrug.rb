class IdsPlease
  class Moikrug < IdsPlease::BaseParser

    MASK = /moikrug/i

    class << self
      def parse(links)
        links.map do |link|
          next if link.host.sub('.moikrug.ru', '') == link.host
          parse_link(link)
        end.compact
      end

      private

      def parse_link(link)
        link.host.sub('.moikrug.ru', '')
      end
    end

  end
end
