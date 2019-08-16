# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreatePdf, type: :interactor do
  describe '.call' do
    before(:each) { stub_github }

    let(:repo) { { owner: 'rspec', repo: 'rspec-rails' } }
    let(:contributors) do
      [
        { login: 'Puzinok', avatar_url: 'https://avatars3.githubusercontent.com/1' },
        { login: 'DHH', avatar_url: 'https://avatars3.githubusercontent.com/2' },
        { login: 'TenderLove', avatar_url: 'https://avatars3.githubusercontent.com/3' }
      ]
    end
    let(:err_contributors) { [] }
    let(:pdf_creator) { CreatePdf.call(contributors: contributors, repo: repo) }
    let(:pdf_error) { CreatePdf.call(contributors: err_contributors, repo: repo) }

    it 'success and create array of pdf' do
      expect(pdf_creator).to be_a_success
      expect(pdf_creator.pdfs).to be_a(Array)
      expect(pdf_creator.pdfs.first).to be_a(Prawn::Document)
    end

    it 'failure and return error message' do
      expect(pdf_error).to be_a_failure
      expect(pdf_error.message).to eq('PDF create error!')
    end
  end
end
