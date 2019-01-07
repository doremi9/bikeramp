# frozen_string_literal: true

module Invoices
  class InvoicesAPI < Base
    desc 'Create an invoice for the user'
    params do
      optional :number, type: String
      optional :creation_date, type: Date
      optional :sale_date, type: Date
      optional :currency, type: String
      optional :payment_method, type: String
      optional :total_net_amount, type: Float
      optional :total_gross_amount, type: Float
      optional :invoice_line_items, type: Array
    end

    post do
      result = InvoiceServices::Create.new(params, current_user).call
      raise ValidationError, result.message unless result.success?

      body false
    end
  end
end
