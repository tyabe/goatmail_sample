PadrinoApp::App.mailer :sample do
  defaults from: "from@example.com", to: "to@example.com"

  email :notice do |message|
    if message.attachment.present?
      add_file filename: message.attachment[:filename], content: File.read(message.attachment[:tempfile].path)
    end
    subject   message.subject
    provides  :plain, :html
    locals    body: message.body
    render    'sample/notice'
  end
end
