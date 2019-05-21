$ ->
  $('#rakuten_check').click ->
    if $('#rakuten_check').prop("checked")
      $('#rakuten_genre').prop("disabled",false)
    else
      $('#rakuten_genre').prop("disabled",true)

  $('#yahoo_check').click ->
    if $('#yahoo_check').prop("checked")
      $('#yahoo_genre').prop("disabled",false)
    else
      $('#yahoo_genre').prop("disabled",true)
