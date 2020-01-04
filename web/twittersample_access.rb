require 'rubygems'
require 'oauth'
require 'json'

CONSUMER_KEY = "GEt1aGSkr4gVKIW9DWIeRZuat"
CONSUMER_SECRET = "G0NS5VRCaHk6XzPIEj0BgIWmuh6LdSLzC3BxxzcZPWyNIWpEIi" 

oauth_consumer = OAuth::Consumer.new(
    CONSUMER_KEY,
    CONSUMER_SECRET,
    site: "https://api.twitter.com"
)

oauth_request_token = OAuth::RequestToken.new(
    oauth_consumer,
    't5y3CgAAAAABBpezAAABb24PaJ0',
    'JKWGjJXTGiGBLVjMeFeEppdZP5GYMaiQ'
)

ret = oauth_request_token.get_access_token(
    {
        oauth_verifier: 'Mt14cQ5DuwQvWDK2AMUWwL50hYPE7F6D'
    },    
)

access_token = ret.token
access_token_secret = ret.secret

oauth_access_token = OAuth::Token.new(access_token, access_token_secret)

url = URI("https://api.twitter.com/1.1/account/verify_credentials.json")
url.query = URI.encode_www_form({
    'include_email': 'true'
})


http = Net::HTTP.new(
    url.host,
    url.port
)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

response = http.start do |http|

    request = Net::HTTP::Get.new(url.request_uri)
    request.oauth!(
        http,
        oauth_consumer,
        oauth_access_token
    )

    http.request(request)
end

response_body = JSON.parse(response.body)

p ({'id': response_body['id'], 'email': response_body['email']})