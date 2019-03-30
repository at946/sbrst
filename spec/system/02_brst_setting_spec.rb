require 'rails_helper'

feature '02_ブレストの条件を設定できること', type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
  end

  scenario "【トップページ】で【ブレストする】ボタンを選択した場合、【ブレスト設定ページ】へ遷移できること" do
    visit root_path
    click_on :start_first_button

    expect(current_path).to eq set_path

    visit root_path
    click_on :start_second_button

    expect(current_path).to eq set_path
  end

  feature "【ブレスト設定ページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :start_first_button
    end

    scenario "【ブレストしたいこと】を入力できること" do
      fill_in :setting_problem, with: @problem
      expect(find("#setting_problem").value).to eq @problem
    end

    scenario "【ブレストしたいこと】が未入力の状態で【ブレストを始める】を選択した場合、「ブレストしたいことを入力してください」とエラーが表示されること" do
      fill_in :setting_problem, with: ""
      click_on :start_brst_button
      expect(page).to have_text "ブレストしたいことを入力してください"
    end

    scenario "【ブレストしたいこと】が【半角スペース】または【全角スペース】のみの状態で【ブレストを始める】を選択した場合、「ブレストしたいことを入力してください」とエラーが表示されること" do
      fill_in :setting_problem, with: " "
      click_on :start_brst_button
      expect(page).to have_text "ブレストしたいことを入力してください"

      fill_in :setting_problem, with: "　"
      click_on :start_brst_button
      expect(page).to have_text "ブレストしたいことを入力してください"

      fill_in :setting_problem, with: " 　"
      click_on :start_brst_button
      expect(page).to have_text "ブレストしたいことを入力してください"
    end

    scenario "【制限時間】を設定できること" do
      fill_in :setting_limit_time, with: @limit_time
      expect(find("#setting_limit_time").value).to eq @limit_time.to_s
    end

    scenario "【制限時間】に半角数字以外を入力できないこと" do
      fill_in :setting_limit_time, with: @problem
      expect(find("#setting_limit_time").value).to eq ""
    end

    scenario "【制限時間】が未入力の状態で【ブレストを始める】を選択した場合、「制限時間を入力してください」とエラーが表示されること" do
      fill_in :setting_limit_time, with: ""
      click_on :start_brst_button
      expect(page).to have_text "制限時間を入力してください"
    end

    scenario "【制限時間】が0以下の状態で【ブレストを始める】を選択した場合、「制限時間は1~10分の間で入力してください」とエラーが表示されること" do
      fill_in :setting_limit_time, with: 0
      click_on :start_brst_button
      expect(page).to have_text "制限時間は1~10分の間で入力してください"

      fill_in :setting_limit_time, with: 1
      click_on :start_brst_button
      expect(page).not_to have_text "制限時間は1~10分の間で入力してください"
    end

    scenario "【制限時間】が11以上の状態で【ブレストを始める】を選択した場合、「制限時間は1~10分の間で入力してください」とエラーが表示されること" do
      fill_in :setting_limit_time, with: 11
      click_on :start_brst_button
      expect(page).to have_text "制限時間は1~10分の間で入力してください"

      fill_in :setting_limit_time, with: 10
      click_on :start_brst_button
      expect(page).not_to have_text "制限時間は1~10分の間で入力してください"
    end

    scenario "【ブレストを始める】を選択した場合、【ブレストページ】へ遷移できること" do
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: @limit_time
      click_on :start_brst_button

      expect(current_path).to eq brst_path
    end
  end

  feature "【ブレストページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :start_first_button
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: @limit_time
      click_on :start_brst_button
    end

    scenario "【ブレスト設定ページ】で設定した【ブレストしたいこと】が表示されていること" do
      expect(page).to have_text @problem
    end

    scenario "【ブレスト設定ページ】で設定した【制限時間】が表示されていること" do
      expect(page).to have_text "1:00"
    end
  end
end
