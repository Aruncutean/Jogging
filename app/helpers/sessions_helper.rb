module SessionsHelper

    def log_in(user)
        session[:user_id] = user.id
    end

    def remember(user)
        user.remember
      
    end

    def current_user
      # raise session[:user_id].inspect
      if (user_id = session[:user_id])
      
        @current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.encrypted[:user_id])
        raise user_id.inspect
        user = User.find_by(id: user_id)
        if user && user.authenticated?(:remember, cookies[:remember_token])
          log_in user
          @current_user = user
        end
      end
        
    end

    def current_user?(user)
        user && user == current_user 
    end
    
    def normal_user?(user)
      user && user.rol=='normal'
    end
    def admin_user?(user)
      user && user.rol=='admin'
    end

    
    def user_manager?(user)
      user && user.rol=='manager'
    end


    
      def logged_in?
        !current_user.nil?
      end
    
      def forget(user)
        user.forget
      end
    
      def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
      end

end
