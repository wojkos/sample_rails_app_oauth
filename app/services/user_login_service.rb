Result = Struct.new(:success, :value) do
  def failure?
    !success
  end
  def success?
    success
  end
end

class UserLoginService
  def initialize(code)
    @params = {
      grant_type: :authorization_code,
      client_id: Rails.application.credentials[:UID],
      client_secret: Rails.application.credentials[:secret],
      redirect_uri: Rails.application.credentials[:callback_uri],
      code: code
    }
  end
  
  def call
    ChainIt.new.chain { get_token(@params) }.
    chain { |result| login_user(result) }.
    result
  end

  private
  
  def get_token(params)
    response = RestClient.post('https://shielded-temple-86762.herokuapp.com/oauth/token', params)
    access_token = JSON.parse(response)['access_token']
    Result.new(true, access_token)
  end

  def login_user(access_token)
    response = RestClient.get('https://shielded-temple-86762.herokuapp.com/api/user/?token=' + access_token)
    user = JSON.parse(response)
    Result.new(true, user)
  end
end