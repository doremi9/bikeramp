require 'prawn'
require 'prawn/measurement_extensions'
require 'prawn/table'

module InvoiceServices
  class PdfGenerator < Prawn::Document
    attr_reader :invoice, :line_items

    FONT_COLOR     = '068eda'
    HEADER_TEXT    = 'Invoice'.freeze
    USER_TITLE     = 'Seller'.upcase.freeze
    USER_ADDRESS   = 'Address'.upcase.freeze
    USER_NIP       = 'Nip'.upcase.freeze
    USER_PHONE     = 'Phone number'.upcase.freeze
    BUYER_TITLE    = 'Buyer'.upcase.freeze
    CREATION_DATE  = 'Creation date'.upcase.freeze
    SALE_DATE      = 'Sale date'.upcase.freeze
    DUE_DATE       = 'Due date'.upcase.freeze
    PAYMENT_METHOD = 'Payment method'.upcase.freeze
    BANK           = 'Bank'.upcase.freeze
    ACCOUNT_NUMBER = 'Account number'.upcase.freeze
    TABLE_FONT_SIZE = 10
    TABLE_BACKGROUND_COLOR = 'F2EEEB'
    TABLE_COLUMN_WIDTHS = { 0 => 9.mm, 1 => 79.mm, 2 => 18.mm, 3 => 20.mm, 4 => 25.mm, 5 => 15.mm, 6 => 28.mm }.freeze
    TABLE_HEADERS  = [I18n.t('pdf.headers.row_num'), I18n.t('pdf.headers.name'),
                   I18n.t('pdf.headers.quantity'), I18n.t('pdf.headers.price_net_amount'), I18n.t('pdf.headers.net_amount'),
                   I18n.t('pdf.headers.vat'), I18n.t('pdf.headers.gross_amount')].freeze

    def initialize(invoice)
      @invoice = invoice
      @line_items = invoice.invoice_line_items

      super(margin: 0)
      
      setup_fonts
      generate
    end

    private

    def generate
      bounding_box [30, 792], width: 560, height: 792 do
        header
        seller_buyer_details
        invoice_details
        line_items_table
        invoice_totals
        signiture_boxes
      end
    end

    def header
      move_down 40
      text HEADER_TEXT, size: 20, style: :bold, color: FONT_COLOR
      move_down 10
      text "No. #{invoice.number}", size: 12, color: FONT_COLOR
    end

    def seller_buyer_details
      move_down 20
      y_position = cursor
      bounding_box([20, y_position], :width => 200) do
        text "#{USER_TITLE}: #{invoice.user.name}"
        text "#{USER_ADDRESS}: ul. Grazyny 11, 97-400 Belchatow"
        text "NIP: 1234567890"
        text "#{USER_PHONE}: 1234567890"
      end
      bounding_box([300, y_position], :width => 200) do
        text "#{BUYER_TITLE}: Some company name"
        text "ADDRESS: Some address"
        text "NIP: 1234567890"
      end
    end

    def invoice_details
      move_down 40
      y_position = cursor
      bounding_box([20, y_position], :width => 200) do
        text "CREATION DATE: #{invoice.creation_date}"
        text "SALE DATE: #{invoice.sale_date}"
        text "DUE DATE: #{invoice.due_date}"
      end
      bounding_box([300, y_position], :width => 200) do
        text "#{PAYMENT_METHOD}: #{invoice.payment_method}"
        text "#{BANK}: ING Bank Śląski"
        text "#{ACCOUNT_NUMBER}: 1234567890"
      end
    end

    def line_items_table
      move_down 20
      font_size TABLE_FONT_SIZE
      table line_item_rows, line_items_table_options do
        row(0).background_color = TABLE_BACKGROUND_COLOR
        columns(2..-1).align = :right
      end
    end

    def signiture_boxes
      move_down 40
      y_position = cursor
      bounding_box([0, y_position], :width => 250, :height => 80) do
        text_box "Signature", at: [bounds.left + 100, cursor - 60]
        transparent(0.5) { stroke_bounds }
      end
      bounding_box([300, y_position], :width => 250, :height => 80) do
        text_box "Signature", at: [bounds.left + 100, cursor - 60]
        transparent(0.5) { stroke_bounds }
      end
    end

    def setup_fonts
      font_families.update(
        'FiraSans' => {
          bold: Rails.root.join('app/assets/fonts/FiraSans-Bold.ttf'),
          normal: Rails.root.join('app/assets/fonts/FiraSans-Regular.ttf')
        }
      )
      font 'FiraSans'
    end

    def line_item_rows
      [TABLE_HEADERS] +
        line_items.each_with_index.map do |line_item, idx|
          [
            idx + 1,
            line_item.name,
            line_item.quantity,
            line_item.price_net.to_f,
            line_item.net_amount.to_f,
            "#{line_item.vat} %",
            line_item.gross_amount.to_f
          ]
        end
    end

    def line_items_table_options
      {
        cell_style: { border_width: 0.5 },
        column_widths: TABLE_COLUMN_WIDTHS,
        header: true
      }
    end

    def line_items_totals
      InvoiceServices::LineItemsCalculator.calculate_total_amount(invoice)
    end

    def invoice_totals
      table(invoice_totals_row, table_totals_options) do
        row(0).background_color = TABLE_BACKGROUND_COLOR
        columns(0).align = :right
      end
    end

    def invoice_totals_row
      [
        ["Total: #{line_items_totals}"]
      ]
    end

    def table_totals_options
      {
        cell_style: { border_width: 0.5 },
        column_widths: { 0 => 194.mm },
        header: false
      }
    end
  end
end
