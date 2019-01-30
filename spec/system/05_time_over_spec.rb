require 'rails_helper'

feature "05_制限時間がすぎるとブレストが終了すること", type: :system, js: true do
  background do
    @problem = "私たちが地球温暖化に対してできること"
    @answer1 = "公共交通機関を利用する"
    @answer2 = "クーラーの使用を控える"
    visit root_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 1
    click_on :start_brasto_button
  end

  scenario "【ブレストページ】でタイマーが１秒ごとにカウントダウンされること" do
    expect(page).to have_text "01:00"
    sleep 1
    expect(page).to have_text "00:59"
  end

  scenario "【ブレストページ】でタイマーが０秒になった場合、【ブレスト結果ページ】へ遷移すること" do
    expect(find("#answer_list").all("li").count).to eq 0
    fill_in :answer, with: @answer1
    click_on :add_button
    fill_in :answer, with: @answer2
    click_on :add_button
    expect(current_path).to eq run_path
    expect(find("#answer_list").all("li").count).to eq 2
    sleep 65
    expect(current_path).to eq result_path
    expect(find("#answer_list").all("li").count).to eq 2
    expect(find("#answer_list").all("li")[0]).to have_text @answer1
    expect(find("#answer_list").all("li")[1]).to have_text @answer2
    expect(page).to have_text @problem
  end

  scenario "【ブレスト結果ページ】で【ブレストページ】で追加した【answer list】が表示されること" do
  end

  scenario "【ブレスト結果ページ】で【トップページ】で設定した【ブレストしたい課題】が表示されること" do
  end
end
