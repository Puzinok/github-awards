class UrlParser
  include Interactor

  def call
    if validate_url(context.url)
      context.repo = convert_url(context.url)
    else
      context.fail!(message: 'Url not correct.')
    end
  end

  private

  def validate_url(url)
    url.match?(/^https:\/\/github.com\/\S+\/\S+$/i)
  end

  def convert_url(url)
    owner, repo = url[/github.com\/(\S+\/\S+)/i, 1].split('/')
    { owner: owner, repo: repo }
  end
end
