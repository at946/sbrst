require 'rails_helper'

feature "07_利用規約を確認したい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
  end

  scenario "【利用規約ページ】に直接アクセスできること" do
    visit tos_path
    expect(current_path).to eq tos_path
  end

  scenario "【トップページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit root_path
    expect(current_path).to eq root_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【ブレスト設定ページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit root_path
    click_on :brst_start_first_button
    expect(current_path)
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【ブレストページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit root_path
    click_on :brst_start_first_button
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button
    expect(current_path).to eq brst_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【ブレスト失敗ページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit root_path
    click_on :brst_start_first_button
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button
    sleep 65
    expect(current_path).to eq result_path
    expect(page).to have_text "RETRY"
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【ブレスト結果ページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit root_path
    click_on :brst_start_first_button
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button
    @answers.each do |ans|
      fill_in :answer, with: ans
      find("#answer").native.send_keys :return
    end
    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq result_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【まとめページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit root_path
    click_on :brst_start_first_button
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button
    @answers.each do |ans|
      fill_in :answer, with: ans
      find("#answer").native.send_keys :return
    end
    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.accept
    click_on :matome_link
    expect(current_path).to eq matome_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【利用規約ページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit tos_path
    expect(current_path).to eq tos_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end

  scenario "【プライバシーポリシーページ】で【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
    visit pp_path
    expect(current_path).to eq pp_path
    click_on :fmenu_to_tos
    expect(current_path).to eq tos_path
  end
end
