class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :twostep_filter

  # Redirect users to the login page if they're logged in
  # but haven't verified their second factor yet.
  def twostep_filter
    if session['current_step'] == 'first_step'
      redirect_to :controller => :second_step, :action => :index and return
    end
  end
end
