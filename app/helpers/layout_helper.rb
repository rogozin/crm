module LayoutHelper
  
   def page_title(header=nil)
    default = "GiftCRM"
    @page_title = [header, default].compact.join(' | ')  
  end

end
