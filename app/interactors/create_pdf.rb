require 'prawn'
require 'open-uri'

class CreatePdf
  include Interactor

  def call
    pdfs = create_pdfs_list(context.contributors, context.repo)
    if pdfs
      context.pdfs = pdfs
    else
      context.fail!(message: 'PDF create error!')
    end
  end

  private

  def create_pdfs_list(contrib, repo)
    raise if contrib.blank?

    contrib.map.with_index(1) do |c, index|
      create_pdf(index, c[:login], c[:avatar_url], repo)
    end

  rescue
    false
  end

  def create_pdf(index, login, avatar_url, repo)
    pdf = Prawn::Document.new
    
    pdf.move_down 100
    pdf.font('Courier') do
      pdf.text "##{index}", align: :center, size: 20, style: :bold
      pdf.text repo.values.join('/'), align: :center, size: 16
    end
    
    pdf.image open(avatar_url), position: :center, vposition: 200, width: 150
    
    pdf.move_down 150
    pdf.font('Courier') do
      pdf.text 'The award goes to', size: 20, align: :center
    end
    pdf.text login, size: 30, align: :center

    pdf
  end
end

