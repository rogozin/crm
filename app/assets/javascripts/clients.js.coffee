jQuery -> 
  $('span.input-helper').click  ->
     $(this).next().attr('value', $(this).text())
