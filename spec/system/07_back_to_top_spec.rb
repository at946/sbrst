require 'rails_helper'

feature "07_トップページに戻れること", type: :system, js: true do
  background do
    @problem = "私たちが地球温暖化に対してできること"
    @answer1 = "公共交通機関を利用する"
    @answer2 = "クーラーの使用を控える"
    visit root_path
  end

  scenario "【トップページ】で【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
    find("#logo").click
    expect(current_path).to eq root_path
  end

  scenario "【ブレストページ】で【ロゴ】を選択した場合、ページ遷移しないこと" do
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 1
    click_on :start_brasto_button
    find("#logo").click
    expect(current_path).to eq run_path
  end

  scenario "【ブレストページ】へダイレクトアクセスした場合、【トップページ】へ遷移すること" do
    visit run_path
    expect(current_path).to eq root_path
  end

  feature "【ブレスト結果ページ】で", type: :system, js: true do
    background do
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: 1
      click_on :start_brasto_button
      click_on :finish_brasto_button
      page.driver.browser.switch_to.alert.accept
    end

    scenario "【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
      find("#logo").click
      expect(current_path).to eq root_path
    end

    scenario "【トップページへ戻る】リンクを選択した場合、【トップページ】へ遷移すること" do
      click_on :top_link
      expect(current_path).to eq root_path
    end
  end

  scenario "【ブレスト結果ページ】にダイレクトアクセスした場合、【トップページ】へ遷移すること" do
    visit result_path
    expect(current_path).to eq root_path
  end
end
