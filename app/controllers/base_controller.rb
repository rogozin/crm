#encoding: utf-8;
class BaseController < ApplicationController
   before_filter :require_user
  access_control do
    allow "Администратор", "Менеджер продаж"
  end

  
end
