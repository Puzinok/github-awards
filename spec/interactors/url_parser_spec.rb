# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlParser, type: :interactor do
  describe '.call' do
    let(:url) { 'https://github.com/rspec/rspec-rails' }
    let(:wrong_url) { 'https://github.com/rspec' }
    let(:converter) { UrlParser.call(url: url) }
    let(:wrong_converter) { UrlParser.call(url: wrong_url) }

    it 'success convert repo link' do
      expect(converter).to be_a_success
      expect(converter.repo).to eq(owner: 'rspec', repo: 'rspec-rails')
    end

    it 'failure if url is wrong' do
      expect(wrong_converter).to be_a_failure
      expect(wrong_converter.message).to eq('Url not correct.')
    end
  end
end
