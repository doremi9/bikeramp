MoneyRails.configure do |config|
  # set the default currency
  config.default_currency = :pln
end

Money.locale_backend = :i18n