require 'ostruct'

module CommonSteps
  def structify(table, key = 'key', value = 'value')
    # Given a table like:
    #   | key | value |
    #   | Foo | Bar   |
    # Then parse as an OpenStruct
    OpenStruct.new(table.hashes.each_with_object({}) do |hash, memo|
      k = hash[key]
      v = hash[value]

      unless v == '<EMPTY>'
        k_sym = k.strip.downcase.underscore.gsub(/\s+/, '_').gsub(/_+/, '_')

        memo[k_sym] = OpenStruct.new(value: v, symbol: k_sym, key: k)
      end

      memo
    end)
  end

  step 'I have signed out' do
    visit destroy_user_session_path
  end

  step 'show me the html' do
    save_and_open_page
  end

  step 'show me a screenshot' do
    screenshot_and_open_image
  end

  step 'I should see a notification :message' do |message|
    within('#flash_notice') do
      expect(page).to have_content(message)
    end
  end

  step 'I should see a warning :message' do |message|
    within('#flash_warning') do
      expect(page).to have_content(message)
    end
  end

  step 'let me debug' do
    require 'pry'
    binding.pry
  end
end
