class ApplicationController < ActionController::Base

    skip_before_action :verify_authenticity_token
    helper_method :current_user, :logged_in?

    private

    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def ensure_logged_in
        redirect_to new_session_url unless current_user
    end

    def ensure_logged_out
        redirect_to user_url(current_user.id) if current_user
    end

    def logged_in?
        !!current_user
    end

    def login!(user)
        @current_user = user
        session[:session_token] = user.reset_session_token
    end

    def logout!
        if logged_in?
            current_user.reset_session_token
            session[:session_token] = nil
            @current_user = nil
        end
    end
end
