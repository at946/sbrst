require 'rails_helper'

feature "06_ブレストに再挑戦できること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
  end

  feature "【ブレスト失敗ページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :start_first_button
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: @limit_time
      click_on :start_brst_button
      sleep 65
    end

    scenario "【再挑戦】ボタンを選択した場合、【ブレスト設定ページ】へ遷移できること" do
      expect(current_path).to eq matome_path
      click_on :retry_brst_button
      expect(current_path).to eq set_path
    end

    scenario "【ブレスト設定ページ】で【設定していたブレストしたいこと】がデフォルトで入力されていること" do
      click_on :retry_brst_button
      expect(find("#setting_problem").value).to eq @problem
    end

    scenario "【ブレスト設定ページ】で【設定していた制限時間】がデフォルトで入力されていること" do
      click_on :retry_brst_button
      expect(find("#setting_limit_time").value).to eq @limit_time.to_s
    end
  end
end
