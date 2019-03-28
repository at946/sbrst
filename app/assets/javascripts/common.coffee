$(document).on 'turbolinks:load', ->

  ########## TOP PAGE BEGIN ##########
  resize_eye_catch()

  $(window).resize ->
    resize_eye_catch()
  ########## TOP PAGE END ##########

resize_eye_catch = ->
  $("#eye_catch").css('height', $(window).height() + 'px')
