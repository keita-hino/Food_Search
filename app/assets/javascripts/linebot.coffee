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

  # 商品検索ボタンが押された時の処理
  $('.search_button').click ->
    # キーワードが未入力の場合はアラートを表示
    if $('#search_word_text').val() == ""
      alert("キーワードを入力してください")
      return

    word = $('#search_word_text').val()
    rakuten_code = $('#rakuten_genre').val()
    yahoo_code = $('#yahoo_genre').val()

    if $('#rakuten_check').prop("checked") && $('#yahoo_check').prop("checked")
      search_query = "【all,#{rakuten_code},#{yahoo_code}】"
    if $('#rakuten_check').prop("checked") && !($('#yahoo_check').prop("checked"))
      search_query = "【rakuten:#{rakuten_code}】"
    if !($('#rakuten_check').prop("checked")) && $('#yahoo_check').prop("checked")
      search_query = "【yahoo:#{yahoo_code}】"

    liff.sendMessages([
          {
            type:'text',
            text: search_query + word
          }
        ])
