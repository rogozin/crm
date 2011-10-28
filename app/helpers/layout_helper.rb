module LayoutHelper
  
   def page_title(header=nil, show_header=true, subtitle = nil)
    default = "GiftCRM"
    @page_title = [header, subtitle, default].compact.join(' | ')  
    content_for(:page_title, header) if show_header
    content_for(:page_subtitle, subtitle)
  end
  

end
