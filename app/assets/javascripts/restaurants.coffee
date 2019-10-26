# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener 'DOMContentLoaded', ->
  elems = document.querySelectorAll('.fixed-action-btn')
  instances = M.FloatingActionButton.init(elems, direction: 'left', hoverEnabled: false)
  return

document.addEventListener 'DOMContentLoaded', ->
  elems = document.querySelectorAll('.modal')
  instances = M.Modal.init(elems, {opacity: 0.5})
  return

# Or with jQuery
$(document).ready ->
  $('.modal').modal()
  return

$(document).ready ->
  $('.store_name').characterCounter()
  return

$(document).ready ->
  $('.exit_button').click ->
    $('.modal').modal('close');

$(document).ready ->
  $('form#restaurant_form')
    .on('ajax:success', (data) ->
      $('.restaurant').html data
      $('.modal').modal('close');
    ).on 'ajax:error', (data) ->
      console.log(data)
      $('.restaurant').html data
