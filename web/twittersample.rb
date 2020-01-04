require 'rubygems'
require 'oauth'

CONSUMER_KEY = "GEt1aGSkr4gVKIW9DWIeRZuat"
CONSUMER_SECRET = "G0NS5VRCaHk6XzPIEj0BgIWmuh6LdSLzC3BxxzcZPWyNIWpEIi" 

consumer = OAuth::Consumer.new(
    CONSUMER_KEY,
    CONSUMER_SECRET,
    site: "https://api.twitter.com"
)

request_token = consumer.get_request_token(
    oauth_callback: 'http://localhost:8900/api/user/twitteroauth_callback/'
)
p request_token.authorize_url
p request_token.token
p request_token.secret