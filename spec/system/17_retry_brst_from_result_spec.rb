require 'rails_helper'

feature "16_ブレスト結果ページからブレスト設定ページへ遷移して次のブレストを行いたい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
  end

  feature "【ブレスト結果ページ】で【SET_LINK】を選択した場合、", type: :system, js: true do
    background do
      visit root_path
      click_on :brst_start_first_button
      fill_in :problem, with: @problem
      fill_in :limit_time, with: @limit_time
      click_on :start_brst_button
      @answers.each do |ans|
        fill_in :answer, with: ans
        find("#answer").native.send_keys :return
      end
      click_on :finish_brst_button
      page.driver.browser.switch_to.alert.accept
      click_on :set_link
    end

    scenario "【ブレスト設定ページ】へ遷移すること" do
      expect(current_path).to eq set_path
    end

    scenario "【ブレスト設定ページ】で【ブレストしたいこと】に【設定していたブレストしたいこと】がデフォルトで入力されていること" do
      expect(find("#problem").value).to eq @problem
    end

    scenario "【ブレスト設定ページ】で【制限時間】に【設定していた制限時間】がデフォルトで入力されていること" do
      expect(find("#limit_time").value).to eq @limit_time.to_s
    end
  end
end
