# frozen_string_literal: true

class InvoiceValidator
  include Virtus.model
  include ActiveModel::Validations

  attribute :number, String
  attribute :creation_date, Date
  attribute :sale_date, Date
  attribute :currency, String
  attribute :payment_method, String
  attribute :total_net_amount_cents, Float
  attribute :total_gross_amount_cents, Float
  attribute :invoice_line_items, Array

  validates(
    :number, :creation_date, :sale_date, :currency,
    :payment_method, :total_net_amount_cents, :total_gross_amount_cents,
    :invoice_line_items, presence: true
  )
end
