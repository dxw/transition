class AuthenticationController < ApplicationController
  # we don't need to authenticate these requests, they create the authentication
  skip_before_action :authenticate

  def index
    if authenticated?
      redirect_to organisations_path and return
    end
  end

  def create
    logger.info("OAuth Response Received")
    data = request.env["omniauth.auth"]

    sign_in(data["uid"], data["info"])
    redirect_to organisations_path
  end

  def destroy
    warden.logout
    redirect_to root_path
  end

private

  def sign_in(uid, info)
    user = User.find_or_create_by!(uid: uid)
    user.update!(name: info["name"], email: info["email"], permissions: ["admin", "GDS Editor"], organisation_content_id: nil)
    warden.set_user user
  end
end
