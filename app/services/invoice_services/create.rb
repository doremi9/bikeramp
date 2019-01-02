module InvoiceServices
  class Create < ApplicationService
    attr_reader :current_user, :invoice_params, :invoice_line_items_params

    def initialize(params, current_user)
      @invoice_params = params.except(:invoice_line_items)
      @invoice_line_items_params = params[:invoice_line_items]
      @current_user = current_user
    end

    def call
      invoice = create_invoice(current_user, invoice_params)
      return failure(message: invoice.errors.full_messages) if invoice.invalid?
      line_items = create_invoice_line_items(invoice, invoice_line_items_params)
      return failure if line_items.map(&:invalid?).include?(true)
      Invoices::GeneratePdfJob.perform_later(invoice)
      success(data: invoice)
    end

    private

    def create_invoice(current_user, invoice_params)
      current_user.invoices.create(invoice_params)
    end

    def create_invoice_line_items(invoice, invoice_line_items_params)
      invoice.invoice_line_items.create(invoice_line_items_params)
    end
  end
end