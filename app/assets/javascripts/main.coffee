# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  ########## COMMON BEGIN ##########
  # mainの高さ調節
  resize_main()

  # mainの高さ調節（windowサイズ変更時）
  $(window).resize ->
    resize_main()
  ########## COMMON END ##########

  ########## BRST PAGE BEGIN ##########
  # 制限時間のカウントダウン
  limit_time = $("#limit_time").text()
  interval = 1 * 1000

  if limit_time > 0
    cal_time(limit_time)
    timer = setInterval ->
      limit_time -= interval
      cal_time(limit_time)
      if limit_time < 0
        clearInterval(timer)
    , interval

  # アンサーをアンサーリストへ追加
  $("#add_answer_form").submit ->
    ans = escape_html($("#answer").val().trim())
    if ans != ""
      $("#answer_list").prepend("
        <div class='col s12'>
          <div class='card my-1'>
            <div class='card-content center-align'>" + ans + "</div>
          </div>
        </div>")
      $("#post_answer_list").append('<input type="hidden" name="answers[]" value="' + ans + '">')
    document.getElementById("answer").focus()
    $("#answer").val("")
    return false
  ########## BRST PAGE END ##########

  ########## KS PAGE BEGIN ##########
  # アンサーカードのソータブル化
  sortable(document.getElementsByClassName("sortable-answer"), "answer")

  # カテゴリーの型
  category_form = (category_name) ->
    html = "
      <div class='category'>
        <hr>
        <div class='category-name-wrapper'>
          #{show_category_name_form(category_name)}
        </div>
        <div class='row sortable-answer py-1 mb-0'></div>
      </div>
    "
    return html

  # カテゴリー名の型
  show_category_name_form = (category_name) ->
    html = "
      <div class='mt-3 mb-1 show-category-name-wrapper'>
        <span class='category-name'>#{category_name}</span>
        <i class='material-icons right delete-category pointer red-text' onclick='delete_category($(this))'>close</i>
        <i class='material-icons right edit-category pointer blue-text' onclick='edit_category($(this))'>edit</i>
      </div>
    "
    return html

  # カテゴリー名フォームの型
  edit_category_name_form = (category_name) ->
    html = "
      <form id='category_name_form'>
        <div class='input-field mb-0'>
          <input name='category_name' id='category_name' class='center-align' value=#{category_name}>
        </div>
      </form>
    "
    return html

  # アンサーの型
  show_answer_form = (answer) ->
    html = "
      <div class='answer'>
        <span class='answer-text'>#{answer}</span>
        <i class='material-icons right delete-answer pointer red-text' onclick='delete_answer($(this))'>close</i>
        <i class='material-icons right edit-answer pointer blue-text' onclick='edit_answer($(this))'>edit</i>
      </div>
    "

  # アンサーフォームの型
  edit_answer_form = (answer) ->
    html = "
      <form id='answer_form'>
        <div class='input-field my-0'>
          <input name='answer' id='answer_input' class='center-align' value=#{answer}>
        </div>
      </form>
    "
    return html

  # カテゴリーの追加
  $("#add_category_button").click ->
    $("#category_area").append(category_form("Category"))
    sortable(document.getElementsByClassName("sortable-answer"), "answer")
    sortable(document.getElementsByClassName("sortable-category"), "category")

  # カテゴリーの削除
  @delete_category = (target) ->
    if confirm("'#{target.closest("div").find("span").text()}'カテゴリーを削除しますか？")
      $("#no_category").prepend(target.closest("div .category").find("div .col"))
      target.closest("div .category").remove()

  # カテゴリー名の編集モード
  @edit_category = (target) ->
    category_name = target.closest("div").find(".category-name").text()
    target.parents("div .category-name-wrapper").prepend(edit_category_name_form(category_name))
    target.parents("div .show-category-name-wrapper").remove()
    $("#category_name").select()

    # カテゴリー名の編集反映（Enter）
    $("#category_name_form").submit ->
      category_name = escape_html($(@).find("#category_name").val().trim())
      if category_name != ""
        show_category($(@), category_name)
      else
        $(@).find("#category_name").val("")
      return false

    # カテゴリー名の編集キャンセル（Focus out）
    $("#category_name").focusout ->
      show_category($(@).closest("form"), category_name)

  # カテゴリー名の編集モード解除
  show_category = (target, category_name) ->
    target.parents("div .category-name-wrapper").prepend(show_category_name_form(category_name))
    target.remove()

  # アンサーの編集モード
  @edit_answer = (target) ->
    answer = target.closest("div").find(".answer-text").text()
    target.parents("div .card-content").prepend(edit_answer_form(answer))
    target.parents("div .answer").remove()
    $("#answer_input").select()

    # アンサーの編集反映（Enter）
    $("#answer_form").submit ->
      answer = escape_html($(@).find("#answer_input").val().trim())
      if answer != ""
        show_answer($(@), answer)
      else
        $(@).find("#answer_input").val("")
      return false

    # アンサーの編集キャンセル（Focus out）
    $("#answer_input").focusout ->
      show_answer($(@).closest("form"), answer)

  # アンサーの編集モード解除
  show_answer = (target, answer) ->
    target.parents("div .card-content").prepend(show_answer_form(answer))
    target.remove()

  # アンサーの削除
  @delete_answer = (target) ->
    if confirm("'#{target.closest("div .answer").find("span").text()}'を削除しますか？")
      target.closest("div .col").remove()

  # FINISHボタン選択でRESULT PAGEへ遷移
  $("#finish_ks_button").click ->
    categories = []
    answers = []
    $(".category").each ->
      categories.push($(@).find(".category-name").text())
      answers_in_category = []
      $(@).find(".answer").each ->
        answers_in_category.push($(@).find("span").text())
      answers.push(answers_in_category)
    $.each(categories, (i, category) ->
      $("<input>").attr({
        type: 'hidden',
        name: "categories[#{i}]",
        value: category
        }).appendTo("#hidden_area")
      $.each(answers[i], (j, answer) ->
        $("<input>").attr({
          type: 'hidden',
          name: "answers[#{i}][]",
          value: answer
          }).appendTo("#hidden_area"))
    )
    $("#finish_ks_form").submit()
  ########## KS PAGE END ##########

  # ブレスト結果ページ：リストを削除する
  $(".delete-badge").click ->
    delete_result_item($(@))

  # ブレスト結果ページ：カテゴリの追加
  $(".result-item").click ->
    $(@).before('
      <li class="list-group-item d-flex justify-content-between align-items-center result-item bg-primary">
        <strong>
          <span class="result-item-name category-name">Group ' + group_count + '</span>
        </strong>
        <span class="badge text-dark">
          <i class="far fa-edit edit-badge mr-3" data-toggle="modal" data-target="#category_name_modal"></i>
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

  # ブレスト結果ページ：editボタンが選択された場合、モーダルのinputがフォーカスされる
  $('#category_name_modal').on 'shown.bs.modal', ->
    $("#category_name_input").focus()

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
    target.append("「" + add_hashtag() + $("#problem").text() + "」<br><br>")
    $("#result_list li").each ->
      if $(@).find(".category-name").length
        target.append("【" + add_hashtag() + $(@).find(".result-item-name").text() + "】<br>")
      else
        target.append("・ " + add_hashtag() + $(@).find(".result-item-name").text() + "<br>")
    target.select()
    target_sp = document.getElementById("copy_target")
    range = document.createRange()
    range.selectNode(target_sp)
    window.getSelection().removeAllRanges()
    window.getSelection().addRange(range)
    document.execCommand("Copy")
    target.remove()
    alert("ブレスト結果をコピーしました！")

  # ブレスト結果ページ：Change Hashtag Mode
  $("#change_hashtag_mode_icon").click ->
    if $(@).hasClass("active")
      $(@).removeClass("active text-secondary")
      $(@).addClass("text-muted")
    else
      $(@).removeClass("text-muted")
      $(@).addClass("active text-secondary")

  # ブレスト結果ページ：Twitterへのシェア
  $("#share_result_on_twitter").click ->
    window.open(
      "https://twitter.com/intent/tweet?text=" + sns_text() + "&url=https%3A%2F%2Fwww.toriaezu-brasto.tk&hashtags=とりあえずブレスト",
      "_blank"
    )

  # ブレスト結果ページ：Facebookへのシェア
  $("#share_result_on_facebook").click ->
    window.open(
      "https://www.facebook.com/dialog/share?app_id=832453100439280&display=popup&quote=" + sns_text() + "&href=https%3A%2F%2Fwww.toriaezu-brasto.tk&hashtag=#とりあえずブレスト",
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
  text = "「" + escape_sns(add_hashtag() + $("#problem").text()) + "」%0a%0a"
  $("#result_list li").each ->
    if $(@).find(".category-name").length
      text += "【" + escape_sns(add_hashtag() + $(@).find(".result-item-name").text()) + "】%0a"
    else
      text += "・%20" + escape_sns(add_hashtag() + $(@).find(".result-item-name").text()) + "%0a"
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

escape_sns = (str) ->
  str = str.replace(/#/g, '%23')
  return str

add_hashtag = ->
  if $("#change_hashtag_mode_icon").hasClass("active")
    return "#"
  return ""

resize_main = ->
  header_height = 0
  footer_height = 0
  if $("nav")[0]
    header_height = $("nav").outerHeight()
  if $("footer")[0]
    footer_height = $("footer").outerHeight()
  main_height = $(window).height() - (header_height + footer_height)
  $("#main_content").css('min-height', main_height + 'px')

# KSページ：アンサーをドラッグ＆ドロップできるようにする
sortable = (els, group, color) ->
  if els.length != 0
    Array.prototype.filter.call(els, (el) ->
      Sortable.create(el, {
        delay: 100,
        group: group,
        ghostClass: "yellow",
        animation: 300,
      })
    )
