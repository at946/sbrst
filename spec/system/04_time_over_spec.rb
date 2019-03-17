require 'rails_helper'

feature "05_制限時間がすぎるとブレストが終了すること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answer = ["answer1", "answer2", "answer3"]
  end

  scenario "【ブレストページ】でタイマーが１秒ごとにカウントダウンされること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    expect(page).to have_text "01:00"

    sleep 1

    expect(page).to have_text "00:59"
  end

  scenario "【ブレストページ】で【アンサー】がない状態でタイマーが０秒になった場合、【ブレスト失敗ページ】へ遷移すること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    sleep 65

    expect(current_path).to eq brst_fail_path
  end

  scenario "【ブレストページ】で【アンサー】がある状態でタイマーが０秒になった場合、【KSページ】へ遷移すること" do
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

    sleep 65

    expect(current_path).to eq ks_path
    expect(page).to have_text @problem
    @answer.each do |ans|
      expect(page).to have_text ans
    end
  end

  scenario "【KSページ】で【ブレストページ】で追加した【アンサー】が表示されること" do
    #
  end

  scenario "【KSページ】で【ブレスト設定ページ】で設定した【ブレストしたいこと】が表示されること" do
    #
  end
end
