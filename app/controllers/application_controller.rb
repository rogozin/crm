#encoding: utf-8;
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper UsersHelper
  

end
