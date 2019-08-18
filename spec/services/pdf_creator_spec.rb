require 'rails_helper'

RSpec.describe PdfCreator do
  describe '#create' do
    before(:each) { stub_github }
    let(:url) { 'https://avatars3.githubusercontent.com/1' }

    it 'create pdf' do
      expect(PdfCreator.create(1, 'DHH', url)).to be_a(Prawn::Document)
    end
  end
end
