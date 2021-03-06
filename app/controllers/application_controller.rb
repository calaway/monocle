class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :authorize!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private
    def authorize!
      unless authorized?
        render file: "/public/404", status: 404, layout: false
      end
    end

    def authorized?
      return true if current_user
      return true if params[:controller] == "sessions" && params[:action].in?(%w(show new create))
    end
end
