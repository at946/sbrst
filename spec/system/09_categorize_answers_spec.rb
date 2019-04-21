require 'rails_helper'

feature "09_ユーザーとして、アンサーをカテゴライズしたい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
    @category_name = "Category Name"

    visit root_path
    click_on :brst_start_first_button
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button
    @answers.each do |ans|
      fill_in :answer, with: ans
      find("#answer").native.send_keys :return
    end
    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.accept
    click_on :matome_link
  end

  scenario "【カテゴリ未設定】の状態で、【まとめページ】へ遷移した場合、デフォルトでカテゴリ未設定の状態で表示されること" do
    expect(page).not_to have_selector(".category")
  end

  scenario "【まとめページ】で【カテゴリ追加ボタン】を選択した場合、【Category】という【カテゴリ名】の【カテゴリ】が追加されること" do
    expect(page).not_to have_text("Category")
    click_on :add_category_button
    find("body").click
    expect(page).to have_text("Category")
  end

  scenario "【まとめページ】で【カテゴリ】が追加された場合、【カテゴリ名】が入力モードでフォーカスされること" do
    expect(page).not_to have_selector("#category_name_form")
    click_on :add_category_button
    expect(page).to have_selector("#category_name_form")
  end

  scenario "【まとめページ】で【編集モードのカテゴリ名】で【Enter】を選択した場合、【カテゴリ名】が更新されて【カテゴリ名】が参照モードになること" do
    expect(page).not_to have_text @category_name
    click_on :add_category_button
    fill_in :category_name, with: @category_name
    find("#category_name").native.send_keys :return
    expect(page).to have_text @category_name
  end

  scenario "【まとめページ】で【編集モードのカテゴリ名】でフォーカスアウトした場合、カテゴリ名の更新がキャンセルされること" do
    click_on :add_category_button
    find("#category_name").native.send_keys :return
    expect(page).to have_text "Category"
    find(".category").find(".category-name").click
    fill_in :category_name, with: @category_name
    find("body").click
    expect(page).to have_text "Category"
    expect(page).not_to have_text @category_name
  end

  scenario "【まとめページ】で【カテゴリ名編集アイコン】を選択した場合、【カテゴリ名】が【編集モード】になりフォーカスされること" do
    click_on :add_category_button
    find("#category_name").native.send_keys :return
    expect(page).not_to have_selector("#category_name_form")
    find(".category").find(".category-name").click
    expect(page).to have_selector("#category_name_form")
  end

  scenario "【まとめページ】で【カテゴリ削除アイコン】を選択した場合、【カテゴリ削除ダイアログ】が表示されること" do
    click_on :add_category_button
    fill_in :category_name, with: @category_name
    find("#category_name").native.send_keys :return
    find(".category").find(".delete-category").click
    page.driver.browser.switch_to.alert.dismiss
  end

  scenario "【カテゴリー削除ダイアログ】で「《カテゴリ名》カテゴリーを削除しますか？」と表示されること" do
    click_on :add_category_button
    fill_in :category_name, with: @category_name
    find("#category_name").native.send_keys :return
    find(".category").find(".delete-category").click
    expect(page.driver.browser.switch_to.alert.text).to eq "'#{@category_name}'カテゴリーを削除しますか？"
    page.driver.browser.switch_to.alert.dismiss
  end

  scenario "【カテゴリー削除ダイアログ】で【キャンセル】を選択した場合、カテゴリーが削除されないこと" do
    click_on :add_category_button
    fill_in :category_name, with: @category_name
    find("#category_name").native.send_keys :return
    expect(all(".category").count).to eq 1
    find(".category").find(".delete-category").click
    page.driver.browser.switch_to.alert.dismiss
    expect(all(".category").count).to eq 1
  end

  scenario "【まとめページ】で【カテゴリー編集モード】の場合、【カテゴリー削除アイコン】が表示されないこと" do
    click_on :add_category_button
    fill_in :category_name, with: @category_name
    find("#category_name").native.send_keys :return
    expect(find(".category")).to have_selector ".delete-category"
    expect(find(".category")).to have_selector ".category-name"
    find(".category").find(".category-name").click
    expect(find(".category")).not_to have_selector ".delete-category"
    expect(find(".category")).not_to have_selector ".category-name"
  end
end
