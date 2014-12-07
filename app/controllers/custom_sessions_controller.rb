class CustomSessionsController < Devise::SessionsController
  skip_before_filter :twostep_filter, :only => [:create, :destroy]
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?

    if session["current_step"].nil?
      # Devise just validated the password for us - we need to verify
      # the second factor
      session["current_step"] = "first_step"
      redirect_to :controller => "second_step", :action => :index and return
    elsif session["current_step"] == "first_step"
      # The user may have tried to access the site even though it hasn't verified
      # its second factor. Redirect him.
      redirect_to :controller => "second_step", :action => :index and return
    elsif session["current_step"] == "second_step"
      # the user is authed -- redirect her directly to their goal
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  def destroy
    session["current_step"] = nil
    super
  end

end
