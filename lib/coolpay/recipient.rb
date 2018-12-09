module CoolPay
  class Recipient
    attr_reader :id, :name

    def initialize(name:)
      @name = name
      @id = find_or_create
    end

    private

    def find_or_create
      recipient = search.last
      unless recipient.nil?
        recipient['id']
      else
        recipient = create
        id_from(create.body) if recipient.code == 201
      end
    end

    def search
      response = RestClient.get(
        search_url,
        { content_type: 'application/json', authorization: CoolPay.authorization } )
      Oj.load(response.body)['recipients']
    end

    def create
      RestClient.post(
        CoolPay::RECIPIENT_URL,
        Oj.dump(recipient(name)),
        { content_type: 'application/json', authorization: CoolPay.authorization } )
    end

    def recipient(name)
      { "recipient" => { "name" => name } }
    end

    def id_from(body)
      Oj.load(body)['recipient']['id']
    end

    def search_url
      CoolPay::RECIPIENT_URL + ['?', URI.encode_www_form(name: name)].join
    end
  end
end
