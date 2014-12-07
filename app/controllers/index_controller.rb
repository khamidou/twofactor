class IndexController < ApplicationController
  skip_before_filter :twostep_filter, :only => [:index]
  def index
  end
end
