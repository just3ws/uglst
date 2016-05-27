# frozen_string_literal: true
RSpec.describe ApplicationHelper, type: :helper do
  describe '#handle_array_or_csv' do
    it 'receives a nil value' do
      expect(helper.handle_array_or_csv(nil)).to be_nil
    end

    it 'receives an array' do
      expect(helper.handle_array_or_csv(%w(hello goodbye))).to eq('hello, goodbye')
    end

    it 'receives a string' do
      expect(helper.handle_array_or_csv('hello, goodbye')).to eq(%w(goodbye hello))
    end

    it 'receives a number' do
      expect { helper.handle_array_or_csv(1) }.to raise_error("Can't handle what I can't recognize Fixnum is not an Array or String")
    end
  end
end
