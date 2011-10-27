module LayoutHelper
  
   def page_title(header=nil, show_header=true, subtitle = nil)
    default = "GiftCRM"
    h = header ?  header.mb_chars.capitalize : nil
    s = subtitle ?  subtitle.mb_chars.capitalize : nil
    @page_title = [h, s, default].compact.join(' | ')  
    content_for(:page_title, h) if show_header
    content_for(:page_subtitle, s)
  end
  

end
