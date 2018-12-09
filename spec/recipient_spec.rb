RSpec.describe 'CoolPay::Recipient' do
  def stub_empty_search
    stub_request(:get, "https://coolpay.herokuapp.com/api/recipients?name=Test%20Recipient").
      to_return(status: 200, body: "{\"recipients\":[]}", headers: {})
  end

  def stub_successful_search
    stub_request(:get, "https://coolpay.herokuapp.com/api/recipients?name=Test%20Recipient").
      to_return(
        status: 200, body: "{\"recipients\":[{\"name\":\"Test Recipient\", \"id\":\"ABC123\"}]}", headers: {})
  end

  def stub_creation
    stub_request(:post, "https://coolpay.herokuapp.com/api/recipients").
      with(body: "{\"recipient\":{\"name\":\"Test Recipient\"}}").
      to_return(status: 201,
        body: "{\"recipient\":{\"name\":\"Test Recipient\", \"id\":\"ABC123\"}}")
  end

  it 'eventually creates a new recipient on initialization' do
    stub_empty_search
    stub_creation
    recipient = CoolPay::Recipient.new(name: "Test Recipient")
    expect(recipient.name).to eq("Test Recipient")
    expect(recipient.id).to eq("ABC123")
  end

  it 'reuses an existing recipient on initialization' do
    stub_successful_search
    recipient = CoolPay::Recipient.new(name: "Test Recipient")
    expect(recipient.name).to eq("Test Recipient")
    expect(recipient.id).to eq("ABC123")
  end
end
