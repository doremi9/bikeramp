require 'rails_helper'

describe AvatarUploader do
  let!(:user) { create(:user) }
  let(:uploader) { described_class.new(user, :avatar)}

  before { allow(SecureRandom).to receive(:uuid).and_return("jpg") }

  subject { File.open("spec/fixtures/files/#{file_name}") { |f| uploader.store!(f) } }

  context 'whitelisted extension' do
    let(:file_name) { "jpg.jpg" }
    let(:expected_path) { "uploads/spec/user/avatar/#{user.id}/jpg.jpg" }

    it 'returns proper store_path' do
      subject
      expect(uploader.store_path).to eq expected_path
    end

    it 'successfully stores the file' do
      subject
      expect(File).to exist Rails.root.join("public", expected_path)
    end
  end

  context 'not whitelisted extension' do
    let(:file_name) { "txt.txt" }

    it "returns proper store_path" do
      expect { subject }.to raise_error(CarrierWave::IntegrityError)
    end
  end

  after do
    uploader.remove!
  end
end