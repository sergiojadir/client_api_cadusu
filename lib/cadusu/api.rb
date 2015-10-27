module Cadusu
	class Api

		def initialize(app_secret, access_token)
			@app_secret = app_secret
			@access_token = access_token
		end

		def get_beneficiario_por_nome_ou_codigo(term)
			set_connection.get do |req|
				req.url "/api/beneficiarios/by_nome_ou_codigo?q=#{term}"
				req.headers['Content-Type'] = 'application/json'
				req.headers['APP-SECRET'] = @app_secret
				req.headers['DIGEST'] = md5
			end
		end

		private
		def set_connection
			@conn = Faraday.new(url: ENV["CADUSU_API_URL"]) do |faraday|
				faraday.request :url_encoded
				faraday.adapter Faraday.default_adapter
			end
		end

		def md5
			Digest::MD5.hexdigest([@access_token, @app_secret].join(":"))
		end
	end
end