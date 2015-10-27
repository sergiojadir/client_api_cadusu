class BeneficiariosController < ApplicationController

	before_action :set_connection, only: [:index]

	def index
		@response = @conn.get_beneficiario_por_nome_ou_codigo(params[:q])

		if @response.status == 429
			flash[:danger] = @response.body["error"]
			render :unauthorized
		elsif @response.status == 511
			flash[:danger] = @response.body["error"]
			render :unauthorized
		else
			@beneficiarios = @response.body["beneficiarios"]
		end
	end

	private
	def set_connection
		@conn = Cadusu::Api.new(ENV["APP_SECRET"], ENV["ACCESS_TOKEN"])
	end
end