RSpec.describe Import::PhpUg, type: :model do
  it 'fetches the user-groups from php.ug' do
    VCR.use_cassette('php_ug', record: :new_episodes) do

      expect(Import::PhpUg.count).to eq(0)

      fetched = Import::PhpUg.fetch
      Import::PhpUg.store(fetched)
      #Import::PhpUg.untransformed # fetch all the php.ug re

      expect(Import::PhpUg.count).to be > 0

    end
  end
end
