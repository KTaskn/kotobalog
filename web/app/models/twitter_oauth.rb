require 'oauth'
require 'json'
class TwitterOauth < ApplicationRecord

    def self.request_token()
        consumer_key = ENV['TWITTER_CONSUMER_KEY']
        consumer_secret = ENV['TWITTER_CONSUMER_SECRET']

        logger.debug('consumer_key is')
        logger.debug(consumer_key)

        consumer = OAuth::Consumer.new(
            consumer_key,
            consumer_secret,
            site: "https://api.twitter.com"
        )

        request_token = consumer.get_request_token(
            oauth_callback: ENV['TWITTER_OAUTH_CALLBACK_URL']
        )

        return request_token.authorize_url, request_token.token, request_token.secret
    end

    def set_profile(oauth_verifier)
        consumer_key = ENV['TWITTER_CONSUMER_KEY']
        consumer_secret = ENV['TWITTER_CONSUMER_SECRET']

        oauth_consumer = OAuth::Consumer.new(
            consumer_key,
            consumer_secret,
            site: "https://api.twitter.com"
        )

        oauth_token = OAuth::RequestToken.new(
            oauth_consumer,
            self.oauth_token,
            self.oauth_token_secret
        )

        ret = oauth_token.get_access_token(
            {
                oauth_verifier: oauth_verifier
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

        response = http.start do |body|
            request = Net::HTTP::Get.new(url.request_uri)
            request.oauth!(
                body,
                oauth_consumer,
                oauth_access_token
            )

            body.request(request)
        end

        case response
            when Net::HTTPSuccess
                response_body = JSON.parse(response.body)
                self.twitter_id = response_body['id']
                self.email = response_body['email']
                self.screen_name = response_body['screen_name']
                self.save()
                return true
            else
                return false
        end
    end
end
