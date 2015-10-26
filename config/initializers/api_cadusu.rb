$api_cadusu = Faraday.new(url: ENV["CADUSU_API_URL"]) do |faraday|
	faraday.request :url_encoded
	faraday.adapter Faraday.default_adapter
end