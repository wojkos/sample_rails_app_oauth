class UsersController < ApplicationController
  def new
    code = params[:code]
    if code
      response = UserLoginService.new(code).call
      @user = response.value
    else
      redirect_to root_path, alert: :Unauthorized
    end
  rescue RestClient::Unauthorized
    redirect_to root_path, alert: :Unauthorized
  end
end
