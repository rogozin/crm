#encoding: utf-8;
class DirectoriesController < BaseController
  access_control do
    allow "admin", "Главный менеджер"
  end
  def index
  end

end
