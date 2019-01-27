require 'rails_helper'

feature "03_ブレストを開始できること", type: :system, js: true do
  background do
    @problem = "このサービスのサービス名を考える"
    @limit_time = 10

    visit root_path
  end

  scenario "【トップページ】で【ブレストしたいこと】が未入力の状態で【ブレストを始める】を選択した場合、「ブレストしたいことを入力してください」とエラー表示されること" do
    fill_in :setting_problem, with: nil
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector '#start_brasto_button'
    expect(page).to have_text "ブレストしたいことを入力してください"
  end

  scenario "【トップページ】で【制限時間】が未入力の状態で【ブレストを始める】を選択した場合、「制限時間を入力してください」とエラー表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: nil
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector "#start_brasto_button"
    expect(page).to have_text "制限時間を入力してください"
  end

  scenario "【トップページ】で【制限時間】が0以下の状態で【ブレストを始める】を選択した場合、「制限時間は1分以上に設定してください」とエラー表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 0
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector "#start_brasto_button"
    expect(page).to have_text "制限時間は1分以上に設定してください"
  end

  scenario "【トップページ】で【制限時間】が11以上の状態で【ブレストを始める】を選択した場合、「制限時間は10分以下に設定してください」とエラー表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 11
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector "#start_brasto_button"
    expect(page).to have_text "制限時間は10分以下に設定してください"
  end

  scenario "【トップページ】で【ブレストしたいこと】【制限時間】を正しく入力した状態で【ブレストを始める】を選択した場合、【ブレストページ】へ遷移できること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_selector "#finish_brasto_button"
  end

  scenario "【ブレストページ】で【トップページ】で入力した【ブレストしたいこと】が表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_text @problem
  end

  scenario "【ブレストページ】で【トップページ】で入力した【制限時間】がタイマー形式で表示されること" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 1
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_text "01:00"
    visit root_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 10
    click_on :start_brasto_button
    expect(current_path).to eq run_path
    expect(page).to have_text "10:00"
  end
end
