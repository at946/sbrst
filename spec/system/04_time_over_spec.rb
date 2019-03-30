require 'rails_helper'

feature "04_制限時間がすぎるとブレストが終了すること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
  end

  feature "【ブレストページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :start_first_button
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: @limit_time
      click_on :start_brst_button
    end

    scenario "タイマーが１秒ごとにカウントダウンされること" do
      expect(page).to have_text "01:00"
      sleep 1
      expect(page).to have_text "00:59"
    end

    scenario "【アンサー】がない状態でタイマーが０秒になった場合、【ブレスト失敗ページ】へ遷移すること" do
      sleep 65
      expect(current_path).to eq ks_path
    end

    scenario "【アンサー】がある状態でタイマーが０秒になった場合、【KSページ】へ遷移すること" do
      @answers.each do |ans|
        fill_in :answer, with: ans
        find("#answer").native.send_keys :return
      end

      sleep 65

      expect(current_path).to eq ks_path
      expect(page).to have_text @problem
      @answers.each do |ans|
        expect(page).to have_text ans
      end
    end
  end
end
