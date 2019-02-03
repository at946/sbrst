require 'rails_helper'

feature "09_ブレスト結果を並び替えれること", type: :system, js: true do
  background do
    @problem = "私たちが地球温暖化に対してできること"
    @answer1 = "公共交通機関を利用する"
    @answer2 = "クーラーの使用を控える"
    visit root_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 1
    click_on :start_brasto_button
    fill_in :answer, with: @answer1
    click_on :add_button
    fill_in :answer, with: @answer2
    click_on :add_button
  end

  scenario "【ブレストページ】で【ブレストリスト】の順番を並び替えられないこと" do
    expect(find("#answer_list").all("li")[0]).to have_text @answer2
    expect(find("#answer_list").all("li")[1]).to have_text @answer1
    source = find("#answer_list").all("li")[0]
    target = find("#answer_list").all("li")[1]
    source.drag_to(target)
    expect(find("#answer_list").all("li")[0]).to have_text @answer2
    expect(find("#answer_list").all("li")[1]).to have_text @answer1
  end

  # scenario "【ブレスト結果ページ】で【ブレストリスト】の順番を並び替えれること" do
  #   click_on :finish_brasto_button
  #   page.driver.browser.switch_to.alert.accept
  #   expect(find("#result_list").all("li")[0]).to have_text @answer1
  #   expect(find("#result_list").all("li")[1]).to have_text @answer2
  #   source = page.find("#result_list").all("li")[0].find(".result_item")
  #   target = page.find("#result_list").all("li")[1].find(".result_item")
  #   source.drag_to target
  #   expect(find("#result_list").all("li")[0]).to have_text @answer2
  #   expect(find("#result_list").all("li")[1]).to have_text @answer1
  # end
end
