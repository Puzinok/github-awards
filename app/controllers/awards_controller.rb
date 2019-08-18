class AwardsController < ApplicationController
  def index
  end

  def download
    repo = JSON.parse($redis.get(awards_params[:repo]))
    author = repo.detect { |k| k['login'] == awards_params[:login] }
    pdf = PdfCreator.create(author['place'], author['login'], author['avatar_url'])

    respond_to do |f|
      f.pdf do
        send_data pdf, type: 'application/pdf'
      end
    end
  end

  def download_zip
    repo = JSON.parse($redis.get(awards_params[:repo]))
    respond_to do |f|
      f.zip do
        files = repo.map do |author|
          PdfCreator.create(author['place'], author['login'], author['avatar_url'])
        end

        compressed_pdfs = ZipCreator.compress(files)
        send_data compressed_pdfs.read, type: 'application/zip'
      end
    end
  end

  def create
    @repo_md5 = Digest::MD5.hexdigest(awards_params[:url])
    @result = FetchStats.call(url: awards_params[:url])

    if @result.success?
      $redis.set(@repo_md5, @result.contributors.to_json, ex: 900_000)
    end
  end

  private

  def awards_params
    params.permit(:login, :url, :repo)
  end
end
