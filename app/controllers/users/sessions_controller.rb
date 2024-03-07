class Users::SessionsController < Devise::SessionsController

  def logout
    # debugger
    
    destroy
    # redirect_to home_index_path
    # debugger
    # session.delete(:devise)
    # sign_out current_user
  end

  private

  def destroy
    super do
      return redirect_to url_for("http://localhost:8080/auth/realms/TrainEducation/protocol/openid-connect/logout?post_logout_redirect_uri=http://localhost:3000/&client_id=TrainEducation"), allow_other_host: true
    end
  end
end