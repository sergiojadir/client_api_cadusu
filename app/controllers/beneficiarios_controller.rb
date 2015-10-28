class BeneficiariosController < ApplicationController

	before_action :set_connection, only: [:index]

	def index
		@beneficiarios = []
		return @beneficiarios unless params[:q]
		@response = @conn.get_beneficiario_por_nome_ou_codigo(params[:q])

		if @response.status == 429
			flash[:danger] = @response.body["error"]
			render :unauthorized
		elsif @response.status == 511 || @response.status == 500
			flash[:danger] = "O servidor retornou o seguinte erro: #{@response.body['error']}"
			render :unauthorized
		else
			@beneficiarios = Kaminari.paginate_array(@response.body["beneficiarios"]).page(params[:page]).per(10)
		end
	end

	private
	def set_connection
		@conn = Cadusu::Api.new(ENV["CADUSU_API_KEY"], ENV["CADUSU_SECRET_API_KEY"])
	end
end