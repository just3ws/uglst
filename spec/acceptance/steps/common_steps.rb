require 'ostruct'

module CommonSteps
  def structify(table, key = 'key', value = 'value')
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

  step 'I have signed out' do
    visit destroy_user_session_path
  end

  step 'show me the page' do
    save_and_open_page
  end
end
