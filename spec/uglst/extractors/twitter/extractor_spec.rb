describe Uglst::Extractors::Twitter::Extractor do
  subject { Uglst::Extractors::Twitter::Extractor }

  describe '.value' do
    %w(
      @uglst
      http://m.twitter.com/uglst
      http://mobile.twitter.com/uglst
      http://twitter.com/uglst
      http://www.twitter.com/uglst
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
        extracted = subject.new(screen_name: pattern)
        expect(extracted.screen_name).to eq('uglst')
        expect(extracted.user_id).to eq(450_382_927)
      end
    end

    it "parses a screen_name with an underscore" do
      expect(subject.new(screen_name: 'php_ug').screen_name).to eq('php_ug')
      expect(subject.new(screen_name: 'http://www.twitter.com/php_ug').screen_name).to eq('php_ug')
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
