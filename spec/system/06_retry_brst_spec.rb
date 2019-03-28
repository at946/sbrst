require 'rails_helper'

feature "06_ブレストに再挑戦できること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answer = ["answer1", "answer2", "answer3"]
  end

  scenario "【ブレスト失敗ページ】で【再挑戦】ボタンを選択した場合、【ブレスト設定ページ】へ遷移できること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.accept

    expect(current_path).to eq brst_fail_path

    click_on :retry_brst_button

    expect(current_path).to eq set_path
  end

  scenario "【ブレスト設定ページ】で【設定していたブレストしたいこと】がデフォルトで入力されていること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.accept

    expect(current_path).to eq brst_fail_path

    click_on :retry_brst_button

    expect(current_path).to eq set_path
    expect(find("#setting_problem").value).to eq @problem
  end

  scenario "【ブレスト設定ページ】で【設定していた制限時間】がデフォルトで入力されていること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.accept

    expect(current_path).to eq brst_fail_path

    click_on :retry_brst_button

    expect(current_path).to eq set_path
    expect(find("#setting_limit_time").value).to eq @limit_time.to_s
  end
end
