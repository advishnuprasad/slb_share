class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token
  after_action :allow_facebook_iframe

  def allow_facebook_iframe
    p "Facebook params: #{params}"
    # response.headers['X-Frame-Options'] = 'ALLOW-FROM https://apps.facebook.com'
    response.headers.except! 'X-Frame-Options'
  end
end
