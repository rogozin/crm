module ClientsHelper
  def firm_name firm
    firm.short_name.present? ? firm.short_name : firm.name
  end
  
  def edit_client_link(firm, text=nil, title=nil)
    link_to_if current_user.is_first_manager? || firm.free? || firm.my?(current_user), text ? text : firm.name, edit_client_path(firm), :title => title    
  end
  
  def edit_user_link(user)
    link_to_if  current_user.is_first_manager? ||  (user.client && (user.client.free? || user.client.my?(current_user))), user.username, edit_user_path(user)
  end

    
end
