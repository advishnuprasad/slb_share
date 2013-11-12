class HomeController < ActionController::Base
  skip_before_filter :verify_authenticity_token
  layout 'application'
  def index
    respond_to do |f|
      f.html
    end
  end
end
