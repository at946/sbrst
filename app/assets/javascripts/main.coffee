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

  $("#copy_icon").click ->
    list = $("#answer_list li")
    $("#copy_area").append('<textarea id="copy_target"></textarea>')
    target = $("#copy_target")
    $("#answer_list li").each ->
      target.append($(@).text() + '\n')
    target.select()
    document.execCommand("Copy")
    target.remove()
    alert("ブレスト結果をコピーしました！")

  $("#add_answer_form").submit ->
    ans = $("#answer").val().trim()
    if ans != ""
      $("#answer_list").prepend("<li class='list-group-item'>" + ans + "</li>")
      $("#post_answer_list").append('<input type="hidden" name="answers[]" value="' + ans + '">')
    $("#answer").val("")
    return false

  if document.getElementById("answer_list") != null
    el = document.getElementById("answer_list")
    sortable = Sortable.create(el, {
      animation: 150
      })

cal_time = (limit_time) ->
  if limit_time >= 0
    $min = ("00" + Math.floor(limit_time / 60 / 1000)).slice(-2)
    $sec = ("00" + limit_time % (60 * 1000) / 1000).slice(-2)
    $last_time = $min + ":" + $sec
    $("#limit_time").text($last_time)
  else
    $("#result_form").submit()
