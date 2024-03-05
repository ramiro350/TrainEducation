class Users::SessionsController < Devise::SessionsController

  def logout
    destroy
    Devise.sign_out_all_scopes
  end

  private

  def destroy
    super do
      return redirect_to url_for("localhost:8080/auth/realms/sefin/protocol/openid-connect/logout?post_logout_redirect_uri=/"), allow_other_host: true
    end
  end
end