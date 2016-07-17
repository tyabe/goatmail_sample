class SampleMailer < ApplicationMailer
  default to:   "to@example.com"

  def notice(message)
    @body = message.body
    if message.attachment.present?
      attachments[message.attachment.original_filename] = message.attachment.tempfile.read
    end
    mail subject: message.subject
  end
end
