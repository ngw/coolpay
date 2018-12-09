RSpec.describe 'CoolPay::CLI' do
  context 'authentication' do
    let(:app) { CoolPay::CLI.new }

    it 'checks when has_token? is true' do
      allow(File).to receive(:exists?).and_return(true)
      expect(app.authenticate!).to be_nil
    end

    it 'breaks when has_token? is false' do
      allow(File).to receive(:exists?).and_return(false)
      expect { app.authenticate! }.to raise_error(ArgumentError)
    end
  end
end
