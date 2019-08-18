require 'rails_helper'

RSpec.describe ZipCreator do
  describe '#compress' do
    let(:pdf) { [ Prawn::Document.new ] }

    it 'create zip' do
      expect(ZipCreator.compress(pdf)).to be_a(StringIO)
    end

    it 'failure if filelist blank' do
      expect(ZipCreator.compress([])).to be false
    end
  end
end