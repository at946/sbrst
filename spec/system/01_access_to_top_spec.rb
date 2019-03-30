require 'rails_helper'

feature '01_トップページにアクセスできること', type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = "1"
    @answers = ["answer1", "answer2", "answer3"]
  end

  scenario "【トップページ】に直接アクセスできること" do
    visit root_path

    expect(current_path).to eq root_path
  end

  scenario "【BRST設定ページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit root_path
    click_on :start_first_button

    expect(current_path).to eq set_path

    click_on :logo

    expect(current_path).to eq root_path
  end

  scenario "【BRSTページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit root_path
    click_on :start_first_button
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    expect(current_path).to eq brst_path

    click_on :logo

    expect(current_path).to eq root_path
  end

  scenario "【BRST失敗ページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit root_path
    click_on :start_first_button
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    sleep 65

    expect(current_path).to eq ks_path
    expect(page).to have_text "RETRY"

    click_on :logo

    expect(current_path).to eq root_path
  end

  scenario "【KSページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
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

    expect(current_path).to eq ks_path

    click_on :logo

    expect(current_path).to eq root_path
  end

  scenario "【Resultページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
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
    click_on :finish_ks_button

    expect(current_path).to eq result_path

    click_on :logo

    expect(current_path).to eq root_path
  end

  scenario "【利用規約ページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit tos_path
    expect(current_path).to eq tos_path
    click_on :logo
    expect(current_path).to eq root_path
  end

  scenario "【プライバシーポリシーページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit pp_path
    expect(current_path).to eq pp_path
    click_on :logo
    expect(current_path).to eq root_path
  end
end
