require 'rails_helper'

feature "10_ユーザーとして、アンサーを編集したい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
    @new_answer = "アンサー"
  end

  feature "【KSページ】で", type: :system, js: true do
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

    scenario "【アンサー】を選択した場合、【アンサー】が【編集モード】になりフォーカスされること" do
      expect(all(".answer").count).to eq @answers.count
      expect(page).not_to have_selector "#answer_form"

      all(".edit-answer")[0].click

      expect(all(".answer").count).to eq @answers.count - 1
      expect(page).to have_selector "#answer_form"
    end

    scenario "【編集モードのアンサー】で【Enter】を選択した場合、【アンサー】が更新されること" do
      (0...@answers.count).each do |i|
        expect(all(".answer")[i]).to have_text @answers[i]
      end
      all(".edit-answer")[1].click
      expect(find("#answer_input").value).to eq @answers[1]
      fill_in :answer_input, with: @new_answer
      expect(find("#answer_input").value).to eq @new_answer
      find("#answer_input").native.send_keys :return
      expect(all(".answer").count).to eq @answers.count
      expect(all(".answer")[0]).to have_text @answers[0]
      expect(all(".answer")[1]).to have_text @new_answer
      expect(all(".answer")[2]).to have_text @answers[2]
      expect(page).not_to have_selector "#answer_form"
    end

    scenario "【KSページ】で【編集モードのアンサー】で【フォーカスアウト】した場合、アンサーの更新がキャンセルされること" do
      (0...@answers.count).each do |i|
        expect(all(".answer")[i]).to have_text @answers[i]
      end

      all(".edit-answer")[1].click
      expect(find("#answer_input").value).to eq @answers[1]
      fill_in :answer_input, with: @new_answer
      expect(find("#answer_input").value).to eq @new_answer
      all(".answer")[1].click

      expect(all(".answer").count).to eq @answers.count
      (0...@answers.count).each do |i|
        expect(all(".answer")[i]).to have_text @answers[i]
      end
      expect(page).not_to have_selector "#answer_form"
    end
  end
end
