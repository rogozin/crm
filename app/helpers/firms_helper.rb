#encoding:utf-8;
module FirmsHelper
  
  def stats firm
    def class_name val
      val > 0 ? "positive" : nil
    end
    
    co_t = firm.commercial_offers.size
    co_w = firm.commercial_offers.where("created_at > ?", 1.week.ago).size
    ord_t = firm.lk_orders.size
    ord_w = firm.lk_orders.where("created_at > ?", 1.week.ago).size
    firm_t = firm.lk_firms.size
    firm_w = firm.lk_firms.where("created_at > ?", 1.week.ago).size
    prod_t = firm.lk_products.active.size
    prod_w = firm.lk_products.active.where("created_at > ?", 1.week.ago).size    
    samp_t = firm.samples.size
    samp_w = firm.samples.where("created_at > ?", 1.week.ago).size        
    res = "" 
    content_tag :table, :class => 'firm-stats' do      
     res += content_tag :tr do
        content_tag(:td, co_t, :title => "Всего КП")  + 
        content_tag(:td, ord_t, :title => "Всего заказов")  + 
        content_tag(:td, firm_t, :title => "Всего клиентов") +
        content_tag(:td, prod_t, :title => "Всего моих товаров") +
        content_tag(:td, samp_t, :title => "Всего образцов") 
      end 
      res += content_tag :tr do
        content_tag(:td, co_w, :title => "КП за посл. неделю", :class => class_name(co_w)) + 
        content_tag(:td, ord_w, :title => "Заказов за посл. неделю", :class => class_name(ord_w)) + 
        content_tag(:td, firm_w, :title => "Клиентов за посл. неделю", :class => class_name(firm_w)) +
        content_tag(:td, prod_w, :title => "Мои товары за посл. неделю", :class => class_name(prod_w)) +
        content_tag(:td, samp_w, :title => "Образцы за посл. неделю", :class => class_name(samp_w))
      end
      res.html_safe   
    end  
  end
  
end
