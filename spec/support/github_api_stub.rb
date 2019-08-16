# frozen_string_literal: true

require 'webmock/rspec'

module GithubApiStub
  def stub_github
    support_path = Rails.root.join('spec', 'support')

    body = File.read support_path.join('rspec_repo.json')
    error_body = File.read support_path.join('rspec_repo_error.json')
    image = File.read support_path.join('avatar.png')

    stub_request(:get, /api.github.com/)
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip, deflate',
          'Host' => 'api.github.com'
        }
      )
      .to_return(status: 200, body: body, headers: {})

    stub_request(:get, %r{api.github.com/repos/error})
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip, deflate',
          'Host' => 'api.github.com'
        }
      )
      .to_return(status: 404, body: error_body, headers: {})

    stub_request(:get, /githubusercontent.com/)
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'
        }
      )
      .to_return(status: 200, body: image, headers: {})
  end
end
