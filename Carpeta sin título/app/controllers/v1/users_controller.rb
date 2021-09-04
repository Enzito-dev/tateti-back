class V1::UsersController < ApplicationController
skip_before_action :verify_authenticity_token, :only => [:create, :signin]

def index
render(json: User.all)
end

def create
path = "/v1/users"
user = User.new(user_params)
msg , status = if user.save
	[{token: user.token}, 200]
	else
	[message_error(path, user.errors.full_messages ), 400]	
	end
render(json: msg, status: status)
end

def signin
path = "/v1/users/signin"
user = User.find_by(username: user_params[:username])
msg, status = if user.present? && user.valid_password?(user_params[:password])
	[{token: user.token}, 200]
	else error = user.blank? ? "This account does not exist" : "Wrong password"
	[message_error(path , error), 400]
	end
render(json: msg, status: status)
	if (status == 200) 
	user.connected = true
	user.save 
	end
end

def logout
#definir el logout
end

def user_params
params.require(:user).permit(:username, :password, :nickname)
end


def message_error (path, message)
msg = {message: [{path: path, message: message }]}
end

end



