module InvoiceServices
  class Create < ApplicationService
    attr_reader :current_user, :params, :invoice_params, :invoice_line_items_params

    def initialize(params, current_user)
      @params = params
      @invoice_params = params.except(:invoice_line_items)
      @invoice_line_items_params = params[:invoice_line_items]
      @current_user = current_user
    end

    def call
      validator = check_form_validity(params)
      return failure(message: validator.errors.full_messages) unless validator.valid?
      invoice = create_invoice(invoice_params)
      create_invoice_line_items(invoice, invoice_line_items_params)
      Invoices::GeneratePdfJob.perform_later(invoice)
      success
    end

    private

    def check_form_validity(params)
      InvoiceValidator.new(params)
    end

    def create_invoice(invoice_params)
      current_user.invoices.create(invoice_params)
    end

    def create_invoice_line_items(invoice, invoice_line_items_params)
      invoice.invoice_line_items.create(invoice_line_items_params)
    end
  end
end
