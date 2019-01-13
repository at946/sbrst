require 'rails_helper'

feature "03_ブレストを開始できること", type: :system, js: true do
  background do
    @problem = "このサービスのサービス名を考える"
    @limit_time = 10

    visit root_path
  end

  scenario "【トップページ】で【ブレストしたい課題】が未入力の状態で【ブレストを始める】を選択した場合、「ブレストしたい課題を入力してください」とエラー表示されること" do
    fill_in :setting_problem, with: nil
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector '#start_brasto_button'
    expect(page).to have_text "ブレストしたい課題を入力してください"
  end

  scenario "【トップページ】で【ブレストする時間】が未入力の状態で【ブレストを始める】を選択した場合、「ブレストする時間を入力してください」とエラー表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: nil
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector "#start_brasto_button"
    expect(page).to have_text "ブレストする時間を入力してください"
  end

  scenario "【トップページ】で【ブレストする時間】が0以下の状態で【ブレストを始める】を選択した場合、「ブレストする時間は1分以上に設定してください」とエラー表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 0
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector "#start_brasto_button"
    expect(page).to have_text "ブレストする時間は1分以上に設定してください"
  end

  scenario "【トップページ】で【ブレストする時間】が31以上の状態で【ブレストを始める】を選択した場合、「ブレストする時間は30分以下に設定してください」とエラー表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 31
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector "#start_brasto_button"
    expect(page).to have_text "ブレストする時間は30分以下に設定してください"
  end

  scenario "【トップページ】で【ブレストしたい課題】【ブレストする時間】を正しく入力した状態で【ブレストを始める】を選択した場合、【ブレストページ】へ遷移できること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector "#finish_brasto_button"
  end

  scenario "【ブレストページ】で【トップページ】で入力した【ブレストしたい課題】が表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_text @problem
  end

  scenario "【ブレストページ】で【トップページ】で入力した【ブレストする時間】がタイマー形式で表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 1
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_text "01:00"
    visit root_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 30
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_text "30:00"    
  end
end
