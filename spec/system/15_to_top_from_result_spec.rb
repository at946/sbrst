require 'rails_helper'

feature "15_ブレスト結果ページからトップページに遷移したい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
  end

  scenario "【ブレスト結果ページ】で【TOP_LINK】を選択した場合、【トップページ】へ遷移すること" do
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

    click_on :top_link

    expect(current_path).to eq root_path
  end
end
