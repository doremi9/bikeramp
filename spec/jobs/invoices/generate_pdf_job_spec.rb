require 'rails_helper'

describe Invoices::GeneratePdfJob, type: :job do
  let(:user) { create(:user) }
  let(:invoice) { create(:invoice, user: user) }
  let(:service_instance) { double }

  it 'calls  service' do
    expect(InvoiceServices::PdfGenerator).to(
      receive(:new).with(invoice).and_return(service_instance)
    )
    expect(service_instance).to receive(:call)
    subject.perform(invoice)
  end
end