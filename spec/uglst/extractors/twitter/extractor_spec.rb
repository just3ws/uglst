describe Uglst::Extractors::Twitter::Extractor do
  subject { Uglst::Extractors::Twitter::Extractor }

  describe '.value' do
    %w(
      @uglst
      http://twitter.com/uglst
      https://m.twitter.com/uglst
      https://mobile.twitter.com/uglst
      https://twitter.com/uglst
      https://www.twitter.com/uglst
      m.twitter.com/uglst
      mobile.twitter.com/uglst
      twitter.com/uglst
      uglst
      www.twitter.com/uglst
    ).each do |pattern|
      it "parses #{pattern}" do
        screen_name = subject.new(pattern).value.screen_name
        expect(screen_name).to eq('uglst')
      end
    end
  end

  describe '#lookup_user_id_for' do
    it 'requests the user_id from twitter for a screen_name' do
      #VCR.use_cassette('lookup_user_id_for uglst', record: :new_episodes) do
        expect(subject.lookup_user_id_for('uglst')).to eq(450_382_927)
      #end
    end
  end

  describe '#lookup_screen_name_for' do
    it 'requests the screen_name from twitter for a user_id' do
      #VCR.use_cassette('lookup_screen_name_for uglst', record: :new_episodes) do
        expect(subject.lookup_screen_name_for('450382927')).to eq('uglst')
      #end
    end
  end
end
