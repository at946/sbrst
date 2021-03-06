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

  ########## SHARE SET PAGE BEGIN ##########
  $("#share_set_link").click ->
    problem = $("#problem").val()
    limit_time = $("#limit_time").val()
    href = "/share_set?problem=" + problem + "&limit_time=" + limit_time
    window.location.href = href

  # ブレスト結果ページ：Twitterへのシェア
  $("#share_set_on_twitter").click ->
    window.open(
      "https://twitter.com/intent/tweet?text=" + sns_text() + "&url=" + ascii($("#url").val()) + "&hashtags=SBRST",
      "_blank"
    )

  # ブレスト結果ページ：Facebookへのシェア
  $("#share_set_on_facebook").click ->
    window.open(
      "https://www.facebook.com/dialog/share?app_id=832453100439280&display=popup&quote=" + sns_text() + "&href=" + ascii($("#url").val()),
      "_blank"
    )
  ########## SHARE SET PAGE END ##########

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
        <li class='collection-item py-2 center-align answer'>#{ans}</li>
      ")
      $("#post_answer_list").append('<input type="hidden" name="answers[0][]" value="' + ans + '">')
      $("#finish_brst_button").prop('disabled', false)
    document.getElementById("answer").focus()
    $("#answer").val("")
    return false
  ########## BRST PAGE END ##########

  ########## MATOME PAGE BEGIN ##########
  # アンサーカードのソータブル化
  sortable(document.getElementsByClassName("sortable-answer"), "answer")
  sortable(document.getElementsByClassName("sortable-category"), "category")

  # カテゴリーの型
  category_form = (category_name) ->
    html = "
      <div class='category'>
        <hr>
        <div class='category-name-wrapper mb-3 mt-5'>
          #{edit_category_name_form(category_name)}
        </div>
        <ul class='sortable-answer collection mb-5'></ul>
      </div>
    "
    return html

  # カテゴリー名の型
  show_category_name_form = (category_name) ->
    html = "
      <h6 class='show-category-name-wrapper center-align'>
        <i class='material-icons left pointer handle'>reorder</i>
        <span class='category-name yellow-text text-darken-4 pointer' onclick='edit_category($(this))'>#{category_name}</span>
        <i class='material-icons right delete-category pointer red-text' onclick='delete_category($(this))'>close</i>
      </h6>
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
        <i class='material-icons left pointer handle'>reorder</i>
        <span class='answer-text pointer' onclick='edit_answer($(this))'>#{answer}</span>
        <i class='material-icons right delete-answer pointer red-text' onclick='delete_answer($(this))'>close</i>
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
    submit_category_name()
    focus_out_category_name("Category")
    $("#category_name").select()

  # カテゴリーの削除
  @delete_category = (target) ->
    if confirm("'#{target.closest("div").find("span").text()}'カテゴリーを削除しますか？")
      $("#no_category").prepend(target.closest("div .category").find("li"))
      target.closest("div .category").remove()

  # カテゴリー名の編集モード
  @edit_category = (target) ->
    category_name = target.text()
    target.parents(".category-name-wrapper").prepend(edit_category_name_form(category_name))
    target.parents(".show-category-name-wrapper").remove()
    $("#category_name").select()
    submit_category_name()
    focus_out_category_name(category_name)

  # カテゴリー名の編集反映（Enter）
  submit_category_name = ->
    $("#category_name_form").submit ->
      category_name = escape_html($(@).find("#category_name").val().trim())
      if category_name != ""
        show_category($(@), category_name)
      else
        $(@).find("#category_name").val("")
      return false

  # カテゴリー名の編集キャンセル（Focus out）
  focus_out_category_name = (category_name) ->
    $("#category_name").focusout ->
      show_category($(@).closest("form"), category_name)

  # カテゴリー名の編集モード解除
  show_category = (target, category_name) ->
    target.parents("div .category-name-wrapper").prepend(show_category_name_form(category_name))
    target.remove()

  # アンサーの編集モード
  @edit_answer = (target) ->
    answer = target.text()
    target.parents("li").prepend(edit_answer_form(answer))
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
    target.parents("li").prepend(show_answer_form(answer))
    target.remove()

  # アンサーの削除
  @delete_answer = (target) ->
    if confirm("'#{target.closest("div").find(".answer-text").text()}'を削除しますか？")
      target.closest("li").remove()

  # FINISHボタン選択でRESULT PAGEへ遷移
  $("#finish_ks_button").click ->
    categories = []
    answers = []

    $(".category").each ->
      categories.push($(@).find(".category-name").text())

      answers_in_category = []
      $(@).find(".answer").each ->
        answers_in_category.push($(@).find(".answer-text").text())

      answers.push(answers_in_category)

    categories.push("")
    answers_in_category = []
    $("#no_category").find(".answer-text").each ->
      answers_in_category.push($(@).text())
    answers.push(answers_in_category)

    $.each(categories, (i, category) ->
      if category != "" || answers[i] != null
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

  ########## RESULT PAGE BEGIN ##########
  # クリップボードへのコピー
  $("#copy_icon").click ->
    target = $("#copy_area")
    target.removeClass("hide")
    target.select()
    target_sp = document.getElementById("copy_area")
    range = document.createRange()
    range.selectNode(target_sp)
    window.getSelection().removeAllRanges()
    window.getSelection().addRange(range)
    document.execCommand("Copy")
    target.addClass("hide")
    alert("ブレスト結果をコピーしました！")

  # ブレスト結果ページ：Twitterへのシェア
  $("#share_result_on_twitter").click ->
    window.open(
      "https://twitter.com/intent/tweet?text=" + sns_text() + "&url=https%3A%2F%2Fwww.toriaezu-brasto.tk&hashtags=SBRST",
      "_blank"
    )

  # ブレスト結果ページ：Facebookへのシェア
  $("#share_result_on_facebook").click ->
    window.open(
      "https://www.facebook.com/dialog/share?app_id=832453100439280&display=popup&quote=" + sns_text() + "&href=https%3A%2F%2Fwww.toriaezu-brasto.tk&hashtag=#SBRST",
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
  target = $("#copy_area")
  text = target.text()
  return ascii(text)

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

ascii = (str) ->
  str = str.replace(/%/g, '%25')
  str = str.replace(/#/g, '%23')
  str = str.replace(/&/g, '%26')
  str = str.replace(/\+/g, '%2b')
  str = str.replace(/\//g, '%2f')
  str = str.replace(/:/g, '%3a')
  str = str.replace(/;/g, '%3b')
  str = str.replace(/\\/g, '%5c')
  str = str.replace(/\^/g, '%5e')
  str = str.replace(/`/g, '%60')
  str = str.replace(/{/g, '%7b')
  str = str.replace(/\|/g, '%7c')
  str = str.replace(/}/g, '%7d')
  str = str.replace(/\r?\n/g, '%0a')
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
        animation: 200,
        handle: ".handle",
      })
    )
