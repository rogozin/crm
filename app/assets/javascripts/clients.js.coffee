jQuery -> 
  $('span.input-helper').live('click',  ->
    pattern = $(this).text()
    input = $(this).parent().find('input')
    val = $(this).parent().find('input').attr('value').replace(' ', '')
    if pattern == 'http://www.'
        val = val.replace('http://','').replace('www.','') if val
    else if pattern == '+7(495)'
        val = val.substring(val.indexOf(')')+1) if val.indexOf(')') >0
    pattern = pattern + val    
    input.attr('value', pattern))
            
      
  $('#add_phone').click -> 
    model = "client"
    model = "person" if $(this).parents('form').attr('action').search /persons/ 
    phones_cnt = $("input[name^='#{model}[phones_attributes]']").size()    
    phone_element="<div class=\"field\">
     <label for=\"#{model}_phones_attributes_#{phones_cnt}_value\">Телефон</label> <span class=\"input-helper\" title=\"формат: +7(495)345-6789\">+7(495)</span>
     <input id=\"#{model}_phones_attributes_#{phones_cnt}_value\" name=\"#{model}[phones_attributes][#{phones_cnt}][value]\" size=\"30\" type=\"text\">
     </div>"
    $(this).parent().before(phone_element)
    false

  $('#add_email').click -> 
    emails_cnt = $('input[name^="client[emails_attributes]"]').size()    
    email_element="<div class=\"field\">
     <label for=\"client_emails_attributes_#{emails_cnt}_value\">Email</label> 
     <input id=\"client_emails_attributes_#{emails_cnt}_value\" name=\"client[emails_attributes][#{emails_cnt}][value]\" size=\"30\" type=\"text\">
     </div>"
    $(this).parent().before(email_element)
    false
      
  $('#add_url').click -> 
    sites_cnt = $('input[name^="client[sites_attributes]"]').size()    
    site_element="<div class=\"field\">
     <label for=\"client_sites_attributes_#{sites_cnt}_value\">Url</label> <span class=\"input-helper\">http://www.</span>
     <input id=\"client_sites_attributes_#{sites_cnt}_value\" name=\"client[sites_attributes][#{sites_cnt}][value]\" size=\"30\" type=\"text\">
     </div>"
    $(this).parent().before(site_element)
    false
    
