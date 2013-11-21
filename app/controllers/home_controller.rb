class HomeController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    respond_to do |f|
      f.html
    end
  end
end
