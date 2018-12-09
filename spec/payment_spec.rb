RSpec.describe 'CoolPay::Payment' do
  def stub_successful_recipient_search
    stub_request(:get, "https://coolpay.herokuapp.com/api/recipients?name=Test%20Recipient").
      to_return(
        status: 200, body: "{\"recipients\":[{\"name\":\"Test Recipient\", \"id\":\"ABC123\"}]}", headers: {})
  end

  def stub_creation
    stub_request(:post, "https://coolpay.herokuapp.com/api/payments").
      with(
        body: "{\"payment\":{\"amount\":10,\"currency\":\"USD\",\"recipient_id\":\"ABC123\"}}").
        to_return(
          status: 201,
          body: "{\"payment\":{\"id\":\"321CBA\",\"amount\":10,\"currency\":\"USD\",\"recipient_id\":\"ABC123\",\"status\":\"processing\"}}",
          headers: {})
  end

  it "creates a payment" do
    stub_successful_recipient_search
    stub_creation
    payment = CoolPay::Payment.new(recipient_name: "Test Recipient", currency: 'USD', amount: 10)
    expect(payment.recipient.name).to eq("Test Recipient")
    expect(payment.id).to eq('321CBA')
    expect(payment.currency).to eq('USD')
    expect(payment.amount).to eq(10)
    expect(payment.status).to eq('processing')
  end
end
