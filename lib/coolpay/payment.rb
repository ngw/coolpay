module CoolPay
  class Payment
    attr_reader :recipient, :currency, :amount, :id, :status

    def initialize(recipient_name:, currency:, amount:)
      @recipient = Recipient.new(name: recipient_name)
      @currency = currency
      @amount = amount
      unless @recipient.nil?
        response = Oj.load(create)
        @status = response['payment']['status']
        @id = response['payment']['id']
      end
    end

    def self.list
      Oj.load(
        RestClient.get(
          CoolPay::PAYMENT_URL,
          { content_type: 'application/json', authorization: CoolPay.authorization } )
        )['payments']
    end

    private

    def create
      RestClient.post(
        CoolPay::PAYMENT_URL,
        Oj.dump(payment),
        { content_type: 'application/json', authorization: CoolPay.authorization } )
    end

    def payment
      {"payment" => {
        "amount" => amount,
        "currency" => currency,
        "recipient_id" => recipient.id
      }}
    end
  end
end
