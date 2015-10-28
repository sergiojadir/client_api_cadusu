require 'faraday_middleware'

module Cadusu
	class Api

		def initialize(app_secret, access_token)
			@conn = connection(app_secret, access_token)
		end

		def get_beneficiario_por_nome_ou_codigo(params)
			@conn.get do |req|
				req.url "/api/beneficiarios/by_nome_ou_codigo?q=#{params}"
			end
		end

		private
		def http_service_faraday
			Faraday.new(url: ENV["CADUSU_API_URL"]) do |faraday|
				faraday.use FaradayMiddleware::ParseJson, content_type: 'application/json'
				faraday.request :url_encoded
				faraday.adapter Faraday.default_adapter
			end
		end

		def connection(app_secret, access_token)
			conn = http_service_faraday
			conn.headers['Content-Type'] = 'application/json'
			conn.headers['App-Secret'] = app_secret
			conn.headers['Authorization'] = digest_tokens(app_secret, access_token)
			conn
		end

		def digest_tokens(app_secret, access_token)
			OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), app_secret, access_token)
		end
	end
end