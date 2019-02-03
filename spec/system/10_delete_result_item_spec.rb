require 'rails_helper'

feature "10_ブレスト結果を１つずつ削除したい", type: :system, js: true do
  background do
    @problem = "私たちが地球温暖化に対してできること"
    @answer1 = "公共交通機関を利用する"
    @answer2 = "クーラーの使用を控える"
    @answer3 = "植林する"
    visit root_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 1
    click_on :start_brasto_button
    fill_in :answer, with: @answer1
    click_on :add_button
    fill_in :answer, with: @answer2
    click_on :add_button
    fill_in :answer, with: @answer3
    click_on :add_button
    click_on :finish_brasto_button
    page.driver.browser.switch_to.alert.accept
  end

  scenario "【ブレスト結果ページ】で【ブレストリスト】で削除したい項目の【delete icon】を選択した場合、【ブレストリスト】から削除されること" do
    expect(find("#result_list").all("li").count).to eq 3
    expect(find("#result_list").all("li")[0]).to have_text @answer1
    expect(find("#result_list").all("li")[1]).to have_text @answer2
    expect(find("#result_list").all("li")[2]).to have_text @answer3
    find("#result_list").all("li")[1].find(".badge").click
    expect(find("#result_list").all("li").count).to eq 2
    expect(find("#result_list").all("li")[0]).to have_text @answer1
    expect(find("#result_list").all("li")[1]).to have_text @answer3
  end
end
