require 'rails_helper'

RSpec.describe PdfCreator do
  describe '#create' do
    before(:each) { stub_github }
    let(:url) { 'https://avatars3.githubusercontent.com/1' }
    let(:pdf) { PdfCreator.create(1, 'DHH', url) }

    it 'create pdf' do
      expect(PDF::Inspector::Text.analyze(pdf).strings).to include('DHH')
    end
  end
end
