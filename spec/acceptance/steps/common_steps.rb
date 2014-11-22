require 'ostruct'

module CommonSteps
  def structify(table, key='key', value='value')
    # Given a table like:
    #   | key | value |
    #   | Foo | Bar   |
    # Then parse as an OpenStruct
    OpenStruct.new(table.hashes.reduce({}) do |memo, hash|
      k = hash[key]
      v = hash[value]

      k_sym = k.strip.downcase.underscore.gsub(/\s+/, '_').gsub(/_+/, '_')

      memo[k_sym] = OpenStruct.new(value: v, symbol: k_sym, key: k)

      memo
    end)
  end
end
