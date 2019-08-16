# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateCerts, type: :interactor do
  describe '.call' do
    before(:each) { stub_github }
    let(:url) { 'https://github.com/rspec/rspec-rails' }
    let(:wrong_url) { 'https://github.com/error/' }

    it 'sussess' do
      expect(CreateCerts.call(url: url)).to be_a_success
    end

    it 'failure' do
      expect(CreateCerts.call(url: wrong_url)).to be_a_failure
    end
  end
end
