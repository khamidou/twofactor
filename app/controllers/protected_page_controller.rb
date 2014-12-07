class ProtectedPageController < ApplicationController
  def index
    puts "JUMP " + session['current_step']
  end
end
