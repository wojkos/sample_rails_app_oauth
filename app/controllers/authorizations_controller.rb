class AuthorizationsController < ApplicationController
  def new
    params = {
      response_type: :code,
      client_id: Rails.application.credentials[:UID],
      redirect_uri: Rails.application.credentials[:callback_uri]
    }
    url = "#{Rails.application.credentials[:auth_url]}?#{params.map { |k,v| "#{k}=#{v}" }.join('&')}"
    redirect_to url
  end
end
