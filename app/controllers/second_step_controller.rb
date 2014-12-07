require 'rotp'

class SecondStepController < ApplicationController
  skip_before_filter :twostep_filter , :only => [:index, :create]

  def index
    if session["current_step"].nil? then puts "NIL" end 
    if session["current_step"] == "first_step" then puts "FS" end 
    if session["current_step"] == "second_step" then puts "SS" end 
    puts "Session : %s" % [session["current_step"]]

    if session["current_step"] == "first_step" then
      puts "tok tok : %s" % [current_user.totp_token]
      totp = ROTP::TOTP.new("sdfsdf", interval:120)
      @token = totp.now
    end
    # Check session and render a page otherwise.
  end

  def create
    if session["current_step"] == "first_step"
      if params[:code]
        totp = ROTP::TOTP.new("sdfsdf", interval:120)
        token = totp.now
        if params[:code] == token
          session["current_step"] = "second_step"
          redirect_to :controller => "index", :action => :index and return
        end
      end
    end
  end
end
