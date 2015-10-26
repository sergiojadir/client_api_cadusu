class BeneficiariosController < ApplicationController

	def index
		@response = $api_cadusu.get do |req|
			term = params[:q]
			req.url "/api/beneficiarios/by_nome_ou_codigo?q=#{term}"
			req.headers['Content-Type'] = 'application/json'
		end
		if @response.status == 200
			@beneficiarios = parse_response_api[:beneficiarios]
		elsif @response.status == 429
			flash[:danger] = parse_errors_api
			render :unauthorized
		else
			@beneficiarios = []
		end
	end

	private
	def parse_response_api
		JSON.parse(@response.body).symbolize_keys!
	end

	def parse_errors_api
		JSON.parse(@response.body)["error"]
	end
end