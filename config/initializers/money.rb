MoneyRails.configure do |config|
  # set the default currency
  config.default_currency = :pln
  config.default_format = {
    no_cents_if_whole: nil,
    symbol: 'PLN'
  }
end

Money.locale_backend = :i18n