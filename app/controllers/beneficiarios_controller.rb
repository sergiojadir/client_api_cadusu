class BeneficiariosController < ApplicationController

	before_action :set_connection

	def index
		@response = @conn.get do |req|
			req.url '/api/beneficiarios/by_nome_ou_codigo?q=joao'
			req.headers['Content-Type'] = 'application/json'
		end
		if @response.status == 200
			@beneficiarios = parse_json[:beneficiarios]
		elsif @response.status == 429
			flash[:danger] = parse_errors
			render :unauthorized
		else
			@beneficiarios = []
		end
	end

	private

	def set_connection
		@conn = Faraday.new(url: ENV["CADUSU_API_URL"]) do |faraday|
			faraday.request :url_encoded
			faraday.adapter Faraday.default_adapter
		end
	end

	def parse_json
		JSON.parse(@response.body).symbolize_keys!
	end

	def parse_errors
		JSON.parse(@response.body)["error"]
	end
end