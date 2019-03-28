require 'rails_helper'

feature '01_トップページにアクセスできること', type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = "1"
  end

  scenario "【トップページ】に直接アクセスできること" do
    visit root_path
    expect(current_path).to eq root_path
  end

  scenario "【BRST設定ページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit set_path
    expect(current_path).to eq set_path
    click_on :logo
    expect(current_path).to eq root_path
  end

  scenario "【BRSTページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button
    expect(current_path).to eq brst_path
    click_on :logo
    expect(current_path).to eq root_path
  end

  scenario "【KSページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit ks_path(answers: ["ans"])
    expect(current_path).to eq ks_path
    click_on :logo
    expect(current_path).to eq root_path
  end

  scenario "【Resultページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit result_path
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

  scenario "【ブレスト失敗ページ】で【ロゴ】を選択した場合、【トップページ】へ遷移できること" do
    visit brst_fail_path
    expect(current_path).to eq brst_fail_path
    click_on :logo
    expect(current_path).to eq root_path
  end
end
