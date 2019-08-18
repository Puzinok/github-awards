require 'zip'

class ZipCreator
  def self.compress(files)
    raise if files.blank?

    filestream = Zip::OutputStream.write_buffer do |z|
      files.each.with_index(1) do |file, index|
        z.put_next_entry "#{index}.pdf"
        z.print file
      end
    end

    filestream.rewind
    filestream
  rescue StandardError
    false
  end
end
