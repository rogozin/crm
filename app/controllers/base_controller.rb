#encoding: utf-8;
class BaseController < ApplicationController
   before_filter :require_user
   before_filter :default_sort
  
  protected 
  def default_sort(sort_field = "name")
    params[:direction]||="asc"
    params[:sort]||="name"
  end

  def order_string
    "#{params[:sort]} #{params[:direction]}"
  end

  
end
