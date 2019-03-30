require "rails_helper"

feature "12_ユーザーとして、結果確認ができること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
  end

  feature "【KSページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :start_first_button
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: @limit_time
      click_on :start_brst_button
      @answers.each do |ans|
        fill_in :answer, with: ans
        find("#answer").native.send_keys :return
      end
      click_on :finish_brst_button
      page.driver.browser.switch_to.alert.accept
    end

    scenario "【カテゴリー】が一つもない状態で【FINISHボタン】を選択した場合、【ブレスト結果ページ】へ遷移できること" do
      click_on :finish_ks_button
      expect(current_path).to eq result_path
    end

    scenario "【No Category】の配下に【アンサー】が存在する状態で【FINISHボタン】を選択した場合、【ブレスト結果ページ】へ遷移できること" do
      click_on :finish_ks_button
      expect(current_path).to eq result_path
      expect(page).to have_text "No Category"
      @answers.each do |ans|
        expect(page).to have_text ans
      end
    end
  end

  scenario "【ブレスト結果ページ】で【ブレストしたいこと】が表示されていること" do
    visit root_path
    click_on :start_first_button
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button
    @answers.each do |ans|
      fill_in :answer, with: ans
      find("#answer").native.send_keys :return
    end
    click_on :finish_brst_button
    page.driver.browser.switch_to.alert.accept
    click_on :finish_ks_button

    expect(page).to have_text @problem
  end
end
