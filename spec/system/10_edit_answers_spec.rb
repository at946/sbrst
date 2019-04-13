require 'rails_helper'

feature "10_ユーザーとして、アンサーを編集したい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
    @new_answer = "new answer"
  end

  feature "【まとめページ】で", type: :system, js: true do
    background do
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

    scenario "【アンサーの編集アイコン】を選択した場合、【アンサー】が【編集モード】になりフォーカスされること" do
      expect(page).not_to have_selector "#answer_form"
      all(".answer")[0].find(".edit-answer").click
      expect(page).to have_selector "#answer_form"
    end

    scenario "【編集モードのアンサー】で【Enter】を選択した場合、【アンサー】が更新されること" do
      @answers.each do |ans|
        expect(page).to have_text ans
      end

      all(".answer")[0].find(".edit-answer").click
      fill_in :answer_input, with: @new_answer
      find("#answer_input").native.send_keys :return

      expect(page).to have_text @new_answer
      expect(page).not_to have_text @answers[0]
      expect(page).to have_text @answers[1]
      expect(page).to have_text @answers[2]
    end

    scenario "【まとめページ】で【編集モードのアンサー】で【フォーカスアウト】した場合、アンサーの更新がキャンセルされること" do
      @answers.each do |ans|
        expect(page).to have_text ans
      end

      all(".answer")[0].find(".edit-answer").click
      fill_in :answer_input, with: @new_answer
      find("body").click

      @answers.each do |ans|
        expect(page).to have_text ans
      end
      expect(page).not_to have_text @new_answer
    end
  end
end
