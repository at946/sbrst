require "rails_helper"

feature "07_ブレストの結果を確認できること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answer = ["answer1", "answer2", "answer3"]

    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button
    fill_in :answer, with: @answer[0]
    find("#answer").native.send_keys :return
    fill_in :answer, with: @answer[1]
    find("#answer").native.send_keys :return
    fill_in :answer, with: @answer[2]
    find("#answer").native.send_keys :return
    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.accept
    click_on :finish_ks_button
  end

  scenario "【KSページ】で【FINISH】を選択した場合、【ブレスト結果ページ】へ遷移できること" do
    expect(current_path).to eq result_path
  end

  scenario "【ブレスト結果ページ】で【ブレストしたいこと】が表示されること" do
    expect(page).to have_text @problem
  end

  scenario "【ブレスト結果ページ】で【アンサー】が表示されること" do
    @answer.each do |ans|
      expect(page).to have_text ans
    end
  end
end
