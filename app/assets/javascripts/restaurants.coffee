# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener 'DOMContentLoaded', ->
  elems = document.querySelectorAll('.fixed-action-btn')
  instances = M.FloatingActionButton.init(elems, direction: 'left', hoverEnabled: false)
  return

$(document).ready ->
  # モーダルセット
  $('.modal').modal()
  # リアルタイムで文字数カウント
  $('.text_filed').characterCounter()
  
  # モーダルを閉じる 
  $('.exit_button').click ->
    $('.modal').modal('close');

  # 登録モーダル内の「登録」ボタンが押された時の処理
  $('form#restaurant_form')
    .on('ajax:success', (data) ->
      $('.restaurant').html data
      $('.modal').modal('close');
    ).on 'ajax:error', (data) ->
      console.log(data)
      $('.restaurant').html data

  $('.user_name').click ->
    user_name = $(this).text()
    if !(confirm("本当に" + user_name + "さんにシェアしてよろしいですか？"))
      return 
    $.ajax
        url: '/restaurants/share'
        type: 'POST'
        data:
          user_id: $(this).data('user-id')
      .done (data) ->
        alert(user_name + 'さんにシェアしました！')
        $('.modal').modal('close');
      .fail (data) ->
        alert('送信に失敗しました。お手数ですが、画面をリロードした後に再度お試しください。')