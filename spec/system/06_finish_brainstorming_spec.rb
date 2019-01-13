require 'rails_helper'

feature "06_制限時間がすぎる前にブレストを終了できること", type: :system, js: true do
  background do
    @problem = "私たちが地球温暖化に対してできること"
    @answer1 = "公共交通機関を利用する"
    @answer2 = "クーラーの使用を控える"
    visit root_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 1
    click_on :start_brasto_button
  end

  scenario "【ブレストページ】で【出し切った】を選択した場合、【ブレスト完了確認ダイアログ】が表示されること" do
  end

  scenario "【ブレスト完了確認ダイアログ】で「ブレストを完了しますか？」と表示されること" do
    click_on :finish_brasto_button
    expect(page.driver.browser.switch_to.alert.text).to eq "ブレストを完了しますか？"
    page.driver.browser.switch_to.alert.dismiss
  end

  scenario "【ブレスト完了確認ダイアログ】で【キャンセル】を選択した場合、【ブレスト完了確認ダイアログ】が閉じること" do
    click_on :finish_brasto_button
    page.driver.browser.switch_to.alert.dismiss
    expect(current_path).to eq run_path
  end

  scenario "【ブレスト完了確認ダイアログ】で【OK】を選択した場合、【ブレスト結果ページ】へ遷移すること" do
    click_on :finish_brasto_button
    page.driver.browser.switch_to.alert.accept
    expect(current_path).to eq result_path
  end

  scenario "【ブレスト結果ページ】で【トップページ】で設定した【ブレストしたい課題】が表示されること" do
    click_on :finish_brasto_button
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text @problem
  end

  scenario "【ブレストページ】で【answer list】がない状態で【ブレスト結果ページ】へ遷移した場合、【ブレスト結果ページ】で「何も思いつきませんでした...」と表示されること" do
    click_on :finish_brasto_button
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text "何も思いつきませんでした..."
  end

  scenario "【ブレストページ】で【answer list】がある状態で【ブレスト結果ページ】へ遷移した場合、【ブレスト結果ページ】で【answer list】が表示されること" do
    fill_in :answer, with: @answer1
    click_on :add_button
    fill_in :answer, with: @answer2
    click_on :add_button
    click_on :finish_brasto_button
    page.driver.browser.switch_to.alert.accept
    expect(find("#answer_list").all("li").count).to eq 2
    expect(find("#answer_list").all("li")[0]).to have_text @answer2
    expect(find("#answer_list").all("li")[1]).to have_text @answer1
  end
end
