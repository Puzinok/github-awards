class GithubApi::RepoStats
  include Interactor

  def call
    contributors = contributors(context.body)
    if contributors
      context.contributors = contributors
    else
      context.fail!(message: 'Contributors data error!')
    end
  end

  private

  def contributors(data)
    raise if data.blank?

    data = data.map { |a| a['author'] }.reverse

    keys = %w[login avatar_url]

    data.take(3).map.with_index(1) do |author, index|
      contrib = author.select { |k| keys.include?(k) }.symbolize_keys
      contrib[:place] = index
      contrib
    end
  rescue StandardError
    false
  end
end
