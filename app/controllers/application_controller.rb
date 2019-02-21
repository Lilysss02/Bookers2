class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	# ログインしていない場合の画面制御
	# before_action :authenticate_user!

	def after_sign_in_path_for(resource)
		# ログイン後、マイページへ遷移
		user_path(current_user.id)
	end

	def after_sign_up_path_for(resouce)
		# サインアップ後のメッセージ
		flash[:notice] = "Welcome! You have signed up successfully."
	end

	def after_sign_out_path_for(resource)
		# サインアウト後、トップページへ遷移
		root_path
	end


	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
	end
end
