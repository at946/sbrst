require 'rails_helper'

feature "08_利用規約とプライバシーポリシーを確認したい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answer = ["answer1", "answer2", "answer3"]
  end

  scenario "【利用規約ページ】に直接アクセスできること" do
    visit tos_path
    expect(current_path).to eq tos_path
  end

  scenario "【プライバシーポリシーページ】に直接アクセスできること" do
    visit pp_path
    expect(current_path).to eq pp_path
  end

  scenario "【トップページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit root_path
    expect(current_path).to eq root_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【トップページ】で【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
    visit root_path
    expect(current_path).to eq root_path
    click_on :fmenu_to_pp
    expect(current_path).to eq pp_path
  end

  scenario "【ブレスト設定ページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit set_path
    expect(current_path).to eq set_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【ブレスト設定ページ】で【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
    visit set_path
    expect(current_path).to eq set_path
    click_on :fmenu_to_pp
    expect(current_path).to eq pp_path
  end

  scenario "【ブレストページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit brst_path("setting[problem]": @problem, "setting[limit_time]": @limit_time )
    expect(current_path).to eq brst_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【ブレストページ】で【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
    visit brst_path("setting[problem]": @problem, "setting[limit_time]": @limit_time )
    expect(current_path).to eq brst_path
    click_on :fmenu_to_pp
    expect(current_path).to eq pp_path
  end

  scenario "【KSページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)
    expect(current_path).to eq ks_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【KSページ】で【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)
    expect(current_path).to eq ks_path
    click_on :fmenu_to_pp
    expect(current_path).to eq pp_path
  end

  scenario "【ブレスト失敗ページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit brst_fail_path(problem: @problem, limit_time: @limit_time)
    expect(current_path).to eq brst_fail_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【ブレスト失敗ページ】で【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
    visit brst_fail_path(problem: @problem, limit_time: @limit_time)
    expect(current_path).to eq brst_fail_path
    click_on :fmenu_to_pp
    expect(current_path).to eq pp_path
  end

  scenario "【ブレスト結果ページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit result_path(problem: @problem, answers: @answer)
    expect(current_path).to eq result_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【ブレスト結果ページ】で【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
    visit result_path(problem: @problem, answers: @answer)
    expect(current_path).to eq result_path
    click_on :fmenu_to_pp
    expect(current_path).to eq pp_path
  end

  scenario "【利用規約ページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit tos_path
    expect(current_path).to eq tos_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【利用規約ページ】で【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
    visit tos_path
    expect(current_path).to eq tos_path
    click_on :fmenu_to_pp
    expect(current_path).to eq pp_path
  end

  scenario "【プライバシーポリシーページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit pp_path
    expect(current_path).to eq pp_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【プライバシーポリシーページ】で【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
    visit pp_path
    expect(current_path).to eq pp_path
    click_on :fmenu_to_pp
    expect(current_path).to eq pp_path
  end
end
