#encoding: utf-8;
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper UsersHelper
  rescue_from  'ActiveRecord::RecordNotFound' do |ex|
    render :file => 'public/404.html', :status => 404, :layout => false
  end
  rescue_from  'Acl9::AccessDenied',  do |ex|
    render :file => 'public/401.html', :status => 401, :layout => false
  end  
  
end
