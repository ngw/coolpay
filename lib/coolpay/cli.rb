module CoolPay
  class CLI < Thor
    package_name "CoolPay"
    map "-L" => :list

    desc "auth USERNAME API_KEY", "authenticates you to the CoolPay endpoint"
    def auth(username, apikey)
      auth = CoolPay::Auth.new(username: username, apikey: apikey)
      puts auth.token
    rescue RestClient::NotFound
      err = "Credentials do not appear to be right."
      raise ArgumentError.new(err)
    end

    desc "recipient RECIPIENT", "fetches an existing recipient or adds a new recipient to CoolPay"
    def recipient(name)
      authenticate!
      recipient = Recipient.new(name: name)
      if recipient.id
        puts "#{name}:#{recipient.id} is ready to receive money"
      else
        raise RuntimeError.new("The recipient failed to create")
      end
    end

    desc "pay RECIPIENT_NAME CURRENCY AMOUNT", "sends money to a recipient"
    def pay(recipient_name, currency, amount)
      authenticate!
      payment = Payment.new(recipient_name: recipient_name, currency: currency, amount: amount)
      if payment.status
        puts "Your payment of #{payment.amount} #{payment.currency} to #{payment.recipient.name} is #{payment.status}"
      else
        raise RuntimeError.new("The payment failed to create")
      end
    end

    desc "list", "lists all payments"
    def list
      authenticate!
      Payment.list.each do |payment|
        puts "Payment #{payment['id']} of #{payment['amount']} #{payment['currency']} to #{payment['recipient_id']} has status #{payment['status']}"
      end
    end

    no_commands do
      def authenticate!
        unless CoolPay.has_token?
          err = "You must authenticate before using the service."
          raise ArgumentError.new(err)
        end
      end
    end
  end
end
