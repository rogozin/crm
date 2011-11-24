jQuery -> 
  $('span.input-helper').click  ->
    pattern = $(this).text()
    input = $(this).parent().find('input')
    val = $(this).parent().find('input').attr('value').replace(' ', '')
    if pattern == 'http://www.'
        val = val.replace('http://','').replace('www.','') if val
    else if pattern == '+7(495)'
        val = val.substring(val.indexOf(')')+1) if val.indexOf(')') >0
    pattern = pattern + val    
    input.attr('value', pattern)
