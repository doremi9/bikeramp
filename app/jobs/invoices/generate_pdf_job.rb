# frozen_string_literal: true

module Invoices
  class GeneratePdfJob < ApplicationJob
    queue_as :default
 
    def perform(invoice)
      pdf = InvoiceServices::PdfGenerator.new(invoice)
      invoice.pdf_data = pdf.render
      invoice.save
    end
  end
end
