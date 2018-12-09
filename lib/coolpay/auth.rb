module CoolPay
  class Auth
    attr_reader :username, :apikey, :token

    def initialize(username:, apikey:)
      @username, @apikey = username, apikey
      @token = load_token
    end

    private

    def load_token
      Oj.load(perform)['token']
    end
    
    def perform
      RestClient.post(CoolPay::LOGIN_URL,
        Oj.dump(credentials), { content_type: :json } )
    end

    def credentials
      { 'username' => username,
        'apikey'   => apikey }
    end
  end
end
