module InvoiceServices
  class LineItemsCalculator
    def self.calculate_total_amount(invoice)
      invoice.invoice_line_items.map(&:gross_amount_cents).sum.to_f
    end
  end
end