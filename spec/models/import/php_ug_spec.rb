RSpec.describe Import::PhpUg, type: :model do
  it 'fetches the user-groups from php.ug and stores them for later importing' do
    VCR.use_cassette('php_ug', record: :new_episodes) do
      expect(Import::PhpUg.count).to eq(0)
      fetched = Import::PhpUg.fetch
      Import::PhpUg.store(fetched)
      expect(Import::PhpUg.count).to be > 0
    end
  end

  context 'php.ug data is already fetched' do
    before do
      # Because fixtures on models with UUID IDs are currently broken.
      Source.find_or_create_by(name: 'PHP.UserGroup') do |m|
        m.description = 'An international meeting-point for the PHP-Community.'
        m.homepage ='http://php.ug/'
        m.twitter = 'https://twitter.com/php_ug'
      end

      VCR.use_cassette('php_ug', record: :new_episodes) do
        Import::PhpUg.store(Import::PhpUg.fetch)
      end
    end

    it 'reads all the untransformed records' do
      VCR.use_cassette('php_ug_fill_geo_data', record: :new_episodes) do
        Import::PhpUg.untransformed
      end
    end
  end
end

# == Schema Information
# Schema version: 20140730061759
#
# Table name: import_php_ugs
#
#  id          :integer          not null, primary key
#  php_ug_id   :integer
#  php_ug_data :json
#  created_at  :datetime
#  updated_at  :datetime
#
