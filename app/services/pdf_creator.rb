require 'prawn'
require 'open-uri'

class PdfCreator
  def self.create(place, login, avatar_url)
    pdf = Prawn::Document.new

    pdf.move_down 100
    pdf.font('Courier') do
      pdf.text "##{place}", align: :center, size: 20, style: :bold
    end

    pdf.image open(avatar_url), position: :center, vposition: 200, width: 150

    pdf.move_down 150
    pdf.font('Courier') do
      pdf.text 'The award goes to', size: 20, align: :center
    end
    pdf.text login, size: 30, align: :center

    pdf.render
  end
end
