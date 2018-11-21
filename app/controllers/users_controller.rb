class UsersController < ApplicationController
  def new
    code = params[:code]
    if code
      params = {
        grant_type: :authorization_code,
        client_id: Rails.application.credentials[:UID],
        client_secret: Rails.application.credentials[:secret],
        redirect_uri: Rails.application.credentials[:callback_uri],
        code: code
      }
      response = RestClient.post('https://shielded-temple-86762.herokuapp.com/oauth/token', params)
      access_token = JSON.parse(response)['access_token']
      response = RestClient.get('https://shielded-temple-86762.herokuapp.com/api/user/?token=' + access_token)
      @user = JSON.parse(response)
    else
      redirect_to root_path, alert: :Unauthorized
    end
  rescue RestClient::Unauthorized
    redirect_to root_path, alert: :Unauthorized
  end
end
