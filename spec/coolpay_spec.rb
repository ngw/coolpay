RSpec.describe 'CoolPay' do
  let (:token_like) { double("token") }

  before do
    allow(File).to receive(:open).with(CoolPay::TOKEN_PATH, 'r').and_return(token_like)
    allow(token_like).to receive(:read).and_return("ABCD-1234-DCBA\n")
  end

  it 'is imported correctly and answers with the right VERSION' do
    expect(CoolPay::VERSION).to eq('0.1')
  end

  it 'sometimes has a token confgured' do
    allow(File).to receive(:exists?).and_return(false, true)
    expect(CoolPay.has_token?).to be_falsey
    expect(CoolPay.has_token?).to be_truthy
  end

  it 'fetches the token from the filesystem' do
    expect(CoolPay.token).to eq("ABCD-1234-DCBA")
  end

  it 'helps generating the /Bearer/ header' do
    expect(CoolPay.authorization).to eq("Bearer ABCD-1234-DCBA")
  end
end
