# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
# vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file. JavaScript code in this file should be added after the last require_* statement.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require rails-ujs
#= require turbolinks
#= require jquery
#= require jquery_ujs
#= require_tree .
#= require materialize

document.addEventListener 'DOMContentLoaded', ->
  elems = document.querySelectorAll('.fixed-action-btn')
  instances = M.FloatingActionButton.init(elems, direction: 'left', hoverEnabled: false)
  return

document.addEventListener 'DOMContentLoaded', ->
  elems = document.querySelectorAll('.modal')
  instances = M.Modal.init(elems, options)
  return
# Or with jQuery
$(document).ready ->
  $('.modal').modal()
  return

$(document).ready ->
  $('.store_name').characterCounter()
  return