module Invoices
  class GeneratePdfJob < ApplicationJob
    queue_as :default
 
    def perform(invoice)
      pdf = InvoiceServices::PdfGenerator.new(invoice)
      file_name = [
        invoice.number.tr('/', '-'),
        invoice.due_date.to_s,
        SecureRandom.urlsafe_base64
      ].join('-') + '.pdf'

      pdf.render_file(file_name)
      file = File.new(file_name)
      invoice.file = file
      File.delete(file_name)
    end
  end
end
