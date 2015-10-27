module Cadusu
	class Api

		def initialize(app_secret, access_token)
			@app_secret = app_secret
			@access_token = access_token
			@conn = set_connection
		end

		def get_beneficiario_por_nome_ou_codigo(term)
			@conn.get do |req|
				req.url "/api/beneficiarios/by_nome_ou_codigo?q=#{term}"
			end
		end

		private
		def connection_api
			@conn = Faraday.new(url: ENV["CADUSU_API_URL"]) do |faraday|
				faraday.request :url_encoded
				faraday.adapter Faraday.default_adapter
			end
		end

		def set_connection
			conn = connection_api
			conn.headers['Content-Type'] = 'application/json'
			conn.headers['App-Secret'] = @app_secret
			conn.headers['Authorization'] = md5
			conn
		end

		def md5
			Digest::MD5.hexdigest([@access_token, @app_secret].join(":"))
		end
	end
end