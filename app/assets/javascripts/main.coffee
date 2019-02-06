# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $limit_time = $("#limit_time").text()
  $interval = 1 * 1000

  # ブレストページ：制限時間のカウントダウン
  if $limit_time > 0
    cal_time($limit_time)
    timer = setInterval ->
      $limit_time -= $interval
      cal_time($limit_time)
      if $limit_time < 0
        clearInterval(timer)
    , $interval

  # ブレストページ：アンサーをアンサーリストへ追加
  $("#add_answer_form").submit ->
    ans = $("#answer").val().trim()
    if ans != ""
      $("#answer_list").prepend("<li class='list-group-item'>" + ans + "</li>")
      $("#post_answer_list").append('<input type="hidden" name="answers[]" value="' + ans + '">')
    document.getElementById("answer").focus()
    $("#answer").val("")
    return false

  # ブレスト結果ページ：クリップボードへのコピー
  $("#copy_icon").click ->
    list = $("#result_list li")
    $("#copy_area").append('<textarea id="copy_target"></textarea>')
    target = $("#copy_target")
    target.append("【" + $("#problem").text() + "】" + '\n')
    list.each ->
      target.append("・" + $(@).find(".result-item").text() + '\n')
    target.select()
    document.execCommand("Copy")
    target.remove()
    alert("ブレスト結果をコピーしました！")

  $("#share_result_on_twitter").click ->
    window.open(
      "https://twitter.com/intent/tweet?text=" + sns_text() + "&url=https%3A%2F%2Fwww.toriaezu-brasto.tk&hashtags=とりあえずブレスト",
      "_blank"
    )

  $("#share_result_on_facebook").click ->
    window.open(
      "https://www.facebook.com/dialog/share?app_id=405634673528282&display=popup&quote=" + sns_text() + "&href=https%3A%2F%2Fwww.toriaezu-brasto.tk&hashtag=#とりあえずブレスト",
      "_blank"
    )

  # ブレスト結果ページ：リストをドラッグ＆ドロップで入れ替える
  if document.getElementById("result_list") != null
    el = document.getElementById("result_list")
    sortable = Sortable.create(el, {
      animation: 150,
      delay: 100
      })

    $(".delete-badge").click ->
      console.log($(@).parent())
      $(@).parent().remove()

cal_time = (limit_time) ->
  if limit_time >= 0
    $min = ("00" + Math.floor(limit_time / 60 / 1000)).slice(-2)
    $sec = ("00" + limit_time % (60 * 1000) / 1000).slice(-2)
    $last_time = $min + ":" + $sec
    $("#limit_time").text($last_time)
  else
    $("#result_form").submit()

sns_text = ->
  text = "【" + $("#problem").text() + "】%0a"
  $("#result_list li").each ->
    text += "・" + $(@).find(".result-item").text() + "%0a"
  return text
