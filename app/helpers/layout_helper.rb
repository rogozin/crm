module LayoutHelper
  
   def page_title(header=nil, show_header=true)
    default = "GiftCRM"
    @page_title = [header, default].compact.join(' | ')  
    content_for(:page_title, header) if show_header
  end

end
