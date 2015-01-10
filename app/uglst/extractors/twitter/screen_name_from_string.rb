#module Uglst
  #module Extractors
    #module Twitter
      #class ScreenNameFromString
        #attr_reader :screen_name

        #TWITTER_PATTERN = /^@?([a-zA-Z0-9_]){1,15}$/i

        #def initialize(input)
          #@screen_name = input.gsub(/^@/, '') if input =~ TWITTER_PATTERN
        #end

        #delegate :to_s, to: :screen_name
      #end
    #end
  #end
#end
