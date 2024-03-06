class Users::SessionsController < Devise::SessionsController

  def logout
    # debugger
    
    destroy
    # debugger
    # session.delete(:devise)
    # sign_out current_user
  end

  private

  def destroy
    super do
      return redirect_to url_for("http://localhost:8080/auth/realms/TrainEducation/protocol/openid-connect/logout"), allow_other_host: true
    end
  end
end