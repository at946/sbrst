# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  limit_time = $("#limit_time").text()
  interval = 1 * 1000
  group_count = 1

  # ブレストページ：制限時間のカウントダウン
  if limit_time > 0
    cal_time(limit_time)
    timer = setInterval ->
      limit_time -= interval
      cal_time(limit_time)
      if limit_time < 0
        clearInterval(timer)
    , interval

  # ブレストページ：アンサーをアンサーリストへ追加
  $("#add_answer_form").submit ->
    ans = escape_html($("#answer").val().trim())
    if ans != ""
      $("#answer_list").prepend("<li class='list-group-item'>" + ans + "</li>")
      $("#post_answer_list").append('<input type="hidden" name="answers[]" value="' + ans + '">')
    document.getElementById("answer").focus()
    $("#answer").val("")
    return false

  # ブレスト結果ページ：リストをドラッグ＆ドロップで入れ替える
  if document.getElementById("result_list") != null
    el = document.getElementById("result_list")
    sortable = Sortable.create(el, {
      animation: 150,
      delay: 100
      })

  # ブレスト結果ページ：リストを削除する
  $(".delete-badge").click ->
    delete_result_item($(@))

  # ブレスト結果ページ：カテゴリの追加
  $(".result-item").click ->
    $(@).before('
      <li class="list-group-item d-flex justify-content-between align-items-center result-item bg-primary" style="cursor: pointer;">
        <strong><span class="result-item-name category-name">Group ' + group_count + '</span></strong>
        <span class="badge text-dark">
          <i class="far fa-edit edit-badge mr-2" data-toggle="modal" data-target="#category_name_modal"></i>
          <i class="fas fa-times delete-badge"></i>
        </span>
      </li>
    ')
    group_count++
    $(".delete-badge").click ->
      delete_result_item($(@))
    $(".edit-badge").click ->
      $(".target-category").removeClass("target-category")
      $(@).closest("li").addClass("target-category")
      edit_category_name($(@))

  # ブレスト結果ページ：モーダルでEnter Keyを入力した場合、Saveボタンを選択したことにする
  $("#category_name_form").submit ->
    $("#category_name_modal_save").click()
    return false

  # ブレスト結果ページ：モーダルでSaveボタンを選択した場合、カテゴリー名が更新される
  $("#category_name_modal_save").click ->
    name = $("#category_name_input").val()
    $(".target-category").find(".category-name").text(name)

  # ブレスト結果ページ：クリップボードへのコピー
  $("#copy_icon").click ->
    $("#copy_area").append('<p id="copy_target"></p>')
    target = $("#copy_target")
    target.append("「" + $("#problem").text() + "」<br><br>")
    $("#result_list li").each ->
      if $(@).find(".category-name").length
        target.append("【" + $(@).find(".result-item-name").text() + "】<br>")
      else
        target.append("・" + $(@).find(".result-item-name").text() + "<br>")
    target.select()
    target_sp = document.getElementById("copy_target")
    range = document.createRange()
    range.selectNode(target_sp)
    window.getSelection().removeAllRanges()
    window.getSelection().addRange(range)
    document.execCommand("Copy")
    target.remove()
    alert("ブレスト結果をコピーしました！")

  # ブレスト結果ページ：Twitterへのシェア
  $("#share_result_on_twitter").click ->
    window.open(
      "https://twitter.com/intent/tweet?text=" + sns_text() + "&url=https%3A%2F%2Fwww.toriaezu-brasto.tk&hashtags=とりあえずブレスト",
      "_blank"
    )

  # ブレスト結果ページ：Facebookへのシェア
  $("#share_result_on_facebook").click ->
    window.open(
      "https://www.facebook.com/dialog/share?app_id=405634673528282&display=popup&quote=" + sns_text() + "&href=https%3A%2F%2Fwww.toriaezu-brasto.tk&hashtag=#とりあえずブレスト",
      "_blank"
    )

cal_time = (limit_time) ->
  if limit_time >= 0
    min = ("00" + Math.floor(limit_time / 60 / 1000)).slice(-2)
    sec = ("00" + limit_time % (60 * 1000) / 1000).slice(-2)
    last_time = min + ":" + sec
    $("#limit_time").text(last_time)
  else
    $("#result_form").submit()

sns_text = ->
  text = "「" + $("#problem").text() + "」%0a%0a"
  $("#result_list li").each ->
    if $(@).find(".category-name").length
      text += "【" + $(@).find(".result-item-name").text() + "】%0a"
    else
      text += "・" + $(@).find(".result-item-name").text() + "%0a"
  text += "%0a"
  return text

delete_result_item = (target) ->
  target.closest("li").remove()

edit_category_name = (target) ->
  $("#category_name_input").val(target.parents("li").find(".result-item-name").text())

escape_html = (str) ->
  str = str.replace(/&/g, '&amp;')
  str = str.replace(/>/g, '&gt;')
  str = str.replace(/</g, '&lt;')
  str = str.replace(/"/g, '&quot;')
  str = str.replace(/'/g, '&#x27;')
  str = str.replace(/`/g, '&#x60;')
  return str
