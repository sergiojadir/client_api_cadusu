class BeneficiariosController < ApplicationController

	before_action :set_connection, only: [:index]

	def index
		@response = @conn.get_beneficiario_por_nome_ou_codigo(params[:q])

		if @response.status == 429
			flash[:danger] = parse_errors_api
			render :unauthorized
		elsif @response.status == 511
			flash[:danger] = parse_errors_api
			render :unauthorized
		else
			@beneficiarios = parse_response_api[:beneficiarios]
		end
	end

	private
	def parse_response_api
		JSON.parse(@response.body).symbolize_keys!
	end

	def parse_errors_api
		JSON.parse(@response.body)["error"]
	end

	def set_connection
		@conn = Cadusu::Api.new(ENV["APP_SECRET"], ENV["ACCESS_TOKEN"])
	end
end