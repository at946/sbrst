require 'rails_helper'

feature "06_制限時間がすぎる前にブレストを終了できること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answer = ["answer1", "answer2", "answer3"]
  end

  scenario "【ブレストページ】で【出し切った！】を選択した場合、【ブレスト完了確認ダイアログ】が表示されること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.dismiss
  end

  scenario "【ブレスト完了確認ダイアログ】で「ブレストを完了しますか？」と表示されること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    click_on :finish_brst_button
    expect(page.driver.browser.switch_to.alert.text).to eq "ブレストを完了しますか？"
    page.driver.browser.switch_to.alert.dismiss
  end

  scenario "【ブレスト完了確認ダイアログ】で【キャンセル】を選択した場合、【ブレスト完了確認ダイアログ】が閉じること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.dismiss
    expect(current_path).to eq brst_path
  end

  scenario "【アンサー】がない状態で【ブレスト完了確認ダイアログ】で【OK】を選択した場合、【ブレスト失敗ページ】へ遷移すること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.accept

    expect(current_path).to eq brst_fail_path
  end

  scenario "【アンサー】がある状態で【ブレスト完了確認ダイアログ】で【OK】を選択した場合、【KSページ】へ遷移すること" do
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

    expect(current_path).to eq ks_path
  end

  scenario "【KSページ】で【ブレスト設定ページ】で設定した【ブレストしたい課題】が表示されること" do
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

    expect(current_path).to eq ks_path
    expect(page).to have_text @problem
  end

  scenario "【KSページ】で【ブレストページ】で追加した【アンサー】が表示されること" do
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

    expect(current_path).to eq ks_path
    @answer.each do |ans|
      expect(page).to have_text ans
    end
  end
end
