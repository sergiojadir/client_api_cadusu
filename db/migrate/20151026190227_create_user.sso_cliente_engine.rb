# This migration comes from sso_cliente_engine (originally 20150913155712)
class CreateUser < ActiveRecord::Migration
  def change
    unless table_exists?(:users)
    	enable_extension 'hstore'
    	
      create_table :users do |t|
        t.string :email, default: "", index: true
        t.string :sign_in_count, default: 0
        t.datetime :current_sign_in_at
        t.datetime :last_sign_in_at
        t.string :current_sign_in_ip
        t.string :last_sign_in_ip
        t.string :perfil
        t.string :sistema, default: Rails.application.class.parent_name.upcase, null: false
        t.string :authentication_token
        t.hstore :atributos_extras

        t.timestamps null: false
      end

      add_index :users, :atributos_extras, using: :gin
    end
  end
end
