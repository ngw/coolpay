require 'oj'
require 'restclient'
require 'thor'
require 'uri'

require_relative 'coolpay/auth'
require_relative 'coolpay/cli'
require_relative 'coolpay/payment'
require_relative 'coolpay/recipient'

module CoolPay
  URL = "https://coolpay.herokuapp.com/api"
  LOGIN_URL = "#{URL}/login"
  RECIPIENT_URL = "#{URL}/recipients"
  PAYMENT_URL = "#{URL}/payments"
  VERSION = '0.1'
  TOKEN_PATH = "#{File.dirname(__FILE__)}/../.token"

  def self.has_token?
    File.exists? TOKEN_PATH
  end

  def self.token
    token ||= File.open(TOKEN_PATH, 'r').read.strip
  rescue Errno::ENOENT
    raise Errno::ENOENT, "you should have saved an authentication token into 'coolpay/.token'"
  end

  def self.authorization
    "Bearer #{self.token}"
  end
end
