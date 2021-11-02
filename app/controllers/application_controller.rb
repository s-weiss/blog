class ApplicationController < ActionController::API
  before_action :authorize

  private
    def authorize
      if !current_user
        head :unauthorized
      end
    end

    def current_user
      user_id = decoded_token[0]["user_id"]
      @current_user = User.find(user_id)
    rescue
      nil
    end

    def decoded_token
      # header: { 'Authorization': 'Bearer <token>' }
      token = request.headers['Authorization'].split(' ')[1]
      JWT.decode(token, nil, false)
    end
end
