# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $limit_time = $("#limit_time").text()
  $interval = 1 * 1000

  if $limit_time > 0
    cal_time($limit_time)
    timer = setInterval ->
      $limit_time -= $interval
      cal_time($limit_time)
      if $limit_time < 0
        clearInterval(timer)
    , $interval

cal_time = (limit_time) ->
  if limit_time >= 0
    $min = ("00" + Math.floor(limit_time / 60 / 1000)).slice(-2)
    $sec = ("00" + limit_time % (60 * 1000) / 1000).slice(-2)
    $last_time = $min + ":" + $sec
    $("#limit_time").text($last_time)
  else
    $("#result_form").submit()
