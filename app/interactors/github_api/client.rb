class GithubApi::Client
  include Interactor

  TOKEN = Rails.application.credentials.github_token

  def call
    context.body = response(context.url)
  end

  def response(url, token = TOKEN)
    response = RestClient.get(url, Authorization: "token #{token}")
    raise RestClient::ExceptionWithResponse if response.code != 200

    JSON.parse(response.body)
  rescue RestClient::ExceptionWithResponse => e
    context.fail!(message: (e.message || 'API error!'))
  end
end
