module Invoices
  class GeneratePdfJob < ApplicationJob
    queue_as :default
 
    def perform(invoice)
      InvoiceServices::PdfGenerator.new(invoice).call
    end
  end
end