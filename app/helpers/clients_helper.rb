module ClientsHelper
  def firm_name firm
    firm.short_name.present? ? firm.short_name : firm.name
  end
  
  def edit_firm_link(firm)
    link_to_if current_user.is_first_manager? || firm.free? || firm.my?(current_user), firm.name, edit_client_path(firm)  
  end
  
  def edit_user_link(user)
    link_to_if  current_user.is_first_manager? ||  (user.client && (user.client.free? || user.client.my?(current_user))), user.username, edit_user_path(user)  
  end

    
end
