require 'rails_helper'

feature "09_ユーザーとして、アンサーをカテゴライズしたい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
    @category_name = "カテゴリー"
  end

  feature "【まとめページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :start_first_button
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: @limit_time
      click_on :start_brst_button
      @answers.each do |ans|
        fill_in :answer, with: ans
        find("#answer").native.send_keys :return
      end
      click_on :finish_brst_button
      page.driver.browser.switch_to.alert.accept
    end

    scenario "【カテゴリ追加ボタン】を選択した場合、【カテゴリ】が追加されること" do
      expect(all(".category").count).to eq 0
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      expect(all(".category").count).to eq 1
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      expect(all(".category").count).to eq 2
    end

    scenario "【カテゴリ名編集アイコン】を選択した場合、【カテゴリ名】が【編集モード】になりフォーカスされること" do
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      expect(all(".category-name").count).to eq 2
      expect(all("#category_name_form").count).to eq 0
      all(".edit-category")[0].click
      expect(all(".category-name").count).to eq 1
      expect(all("#category_name_form").count).to eq 1
    end

    scenario "【編集モードのカテゴリ名】で【Enter】を選択した場合、【カテゴリ名】が更新されること" do
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      expect(all(".category-name")[0]).to have_text "Category"
      expect(all(".category-name")[1]).to have_text "Category"
      all(".edit-category")[0].click
      expect(find("#category_name").value).to eq "Category"
      fill_in :category_name, with: @category_name
      expect(find("#category_name").value).to eq @category_name
      find("#category_name").native.send_keys :return
      expect(all(".category-name").count).to eq 2
      expect(all(".category-name")[0]).to have_text @category_name
      expect(all(".category-name")[1]).to have_text "Category"
      expect(all("#category_name_form").count).to eq 0
    end

    scenario "【編集モードのカテゴリ名】で【フォーカスアウト」した場合、カテゴリ名の更新がキャンセルされること" do
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      click_on :add_category_button
      find("#category_name").native.send_keys :return

      expect(all(".category-name")[0]).to have_text "Category"
      expect(all(".category-name")[1]).to have_text "Category"

      all(".edit-category")[0].click

      expect(find("#category_name").value).to eq "Category"

      fill_in :category_name, with: @category_name

      expect(find("#category_name").value).to eq @category_name

      find("body").click

      expect(all(".category-name").count).to eq 2
      expect(all(".category-name")[0]).to have_text "Category"
      expect(all(".category-name")[1]).to have_text "Category"
      expect(all("#category_name_form").count).to eq 0
    end

    scenario "【カテゴリ削除アイコン】を選択した場合、【カテゴリ削除ダイアログ】が表示されること" do
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      all(".delete-category")[0].click
      page.driver.browser.switch_to.alert.dismiss
    end

    scenario "【カテゴリー削除ダイアログ】で「'カテゴリー名'カテゴリーを削除しますか？」と表示されること" do
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      all(".edit-category")[0].click
      fill_in :category_name, with: @category_name
      find("#category_name").native.send_keys :return

      all(".delete-category")[0].click
      expect(page.driver.browser.switch_to.alert.text).to eq "'#{@category_name}'カテゴリーを削除しますか？"
      page.driver.browser.switch_to.alert.dismiss
    end

    scenario "【カテゴリー削除ダイアログ】で【キャンセル】を選択した場合、カテゴリーが削除されないこと" do
      expect(page).not_to have_text "Category"
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      expect(page).to have_text "Category"
      all(".delete-category")[0].click
      page.driver.browser.switch_to.alert.dismiss
      expect(page).to have_text "Category"
    end

    scenario "【カテゴリー編集モード】の場合、【カテゴリー削除アイコン】が表示されないこと" do
      click_on :add_category_button
      find("#category_name").native.send_keys :return
      expect(all(".delete-category").count).to eq 1
      all(".edit-category")[0].click
      expect(all(".delete-category").count).to eq 0
    end
  end
end
