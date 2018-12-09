RSpec.describe 'CoolPay::Auth' do
  before do
    stub_request(:post, "https://coolpay.herokuapp.com/api/login")
      .with(body: "{\"username\":\"testuser\",\"apikey\":\"testapikey\"}")
      .to_return(status: 200, body: "{\"token\":\"shamelessfake123\"}", headers: {})
  end

  it 'can be initialized with username and apikey' do
    auth = CoolPay::Auth.new(username: 'testuser', apikey: 'testapikey')
    expect(auth.username).to eq('testuser')
    expect(auth.apikey).to eq('testapikey')
  end

  it 'retrieves a token' do
    auth = CoolPay::Auth.new(username: 'testuser', apikey: 'testapikey')
    expect(auth.token).to eq('shamelessfake123')
  end
end
