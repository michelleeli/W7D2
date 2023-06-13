class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def logged_in?
        !!current_user
    end 

    def login(user) #reset user = session session_tokens
        session[:session_token] = user.reset_session_token
    end 

    def logout
        current_user.reset_session_token if logged_in?
        session[:session_token] = nil
        current_user = nil
    end 

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end 

    # def require_logged_in #login if not logged in
    #     redirect_to new_session_url unless logged_in?
    # end 

    # def require_logged_out #index page 
    #     redirect_to users_url if logged_in?
    # end

end

#CHRRLLL