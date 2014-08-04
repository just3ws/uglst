RSpec.describe Import::PhpUg, type: :model do
  it 'fetches the user-groups from php.ug' do
    VCR.use_cassette('php_ug') do
    end
  end
end
