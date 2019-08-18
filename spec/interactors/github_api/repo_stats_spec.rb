require 'rails_helper'

RSpec.describe GithubApi::RepoStats, type: :interactor do
  describe '.call' do
    before(:each) { stub_github }

    let(:body) { JSON.load (File.open Rails.root.join('spec', 'support', 'rspec_repo.json')) }
    let(:repo) { GithubApi::RepoStats.call(body: body, url: "https://api.github.com/repos/rails/rails/stats/contributors") }
    let(:fail_repo) { GithubApi::RepoStats.call(body: []) }

    it 'success, and return top 3 authors' do
      expect(repo).to be_a_success
      expect(repo.contributors.count).to eq 3
    end

    it 'failure, and return message' do
      expect(fail_repo).to be_a_failure
      expect(fail_repo.message).to eq 'Contributors data error!'
    end
  end
end
