require 'rails_helper'

feature "08_利用規約とプライバシーポリシーを確認したい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
  end

  scenario "【利用規約ページ】に直接アクセスできること" do
    visit tos_path
    expect(current_path).to eq tos_path
  end

  scenario "【プライバシーポリシーページ】に直接アクセスできること" do
    visit pp_path
    expect(current_path).to eq pp_path
  end

  feature "【トップページ】で", type: :system, js: true do
    background do
      visit root_path
      expect(current_path).to eq root_path
    end

    scenario "【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      click_on :fmenu_to_tos
      expect(current_path).to eq tos_path
    end

    scenario "【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      click_on :fmenu_to_pp
      expect(current_path).to eq pp_path
    end
  end

  feature "【ブレスト設定ページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :start_first_button
      expect(current_path).to eq set_path
    end

    scenario "【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      click_on :fmenu_to_tos
      expect(current_path).to eq tos_path
    end

    scenario "【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      click_on :fmenu_to_pp
      expect(current_path).to eq pp_path
    end
  end

  feature "【ブレストページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :start_first_button
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: @limit_time
      click_on :start_brst_button
      expect(current_path).to eq brst_path
    end

    scenario "【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      click_on :fmenu_to_tos
      expect(current_path).to eq tos_path
    end

    scenario "【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      click_on :fmenu_to_pp
      expect(current_path).to eq pp_path
    end
  end

  feature "【まとめページ】で", type: :system, js: true do
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
      expect(current_path).to eq matome_path
    end

    scenario "【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      click_on :fmenu_to_tos
      expect(current_path).to eq tos_path
    end

    scenario "【まとめページ】で【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      click_on :fmenu_to_pp
      expect(current_path).to eq pp_path
    end
  end

  feature "【ブレスト失敗ページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :start_first_button
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: @limit_time
      click_on :start_brst_button
      sleep 65
      expect(current_path).to eq matome_path
      expect(page).to have_text "RETRY"
    end

    scenario "【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      click_on :fmenu_to_tos
      expect(current_path).to eq tos_path
    end

    scenario "【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      click_on :fmenu_to_pp
      expect(current_path).to eq pp_path
    end
  end

  feature "【ブレスト結果ページ】で", type: :system, js: true do
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
      click_on :finish_ks_button
      expect(current_path).to eq result_path
    end

    scenario "【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      click_on :fmenu_to_tos
      expect(current_path).to eq tos_path
    end

    scenario "【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      click_on :fmenu_to_pp
      expect(current_path).to eq pp_path
    end
  end

  feature "【利用規約ページ】で", type: :system, js: true do
    background do
      visit tos_path
      expect(current_path).to eq tos_path
    end

    scenario "【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      click_on :fmenu_to_tos
      expect(current_path).to eq tos_path
    end

    scenario "【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      click_on :fmenu_to_pp
      expect(current_path).to eq pp_path
    end
  end

  feature "【プライバシーポリシーページ】で", type: :system, js: true do
    background do
      visit pp_path
      expect(current_path).to eq pp_path
    end

    scenario "【フッターメニュー】の【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      click_on :fmenu_to_tos
      expect(current_path).to eq tos_path
    end

    scenario "【フッターメニュー】の【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      click_on :fmenu_to_pp
      expect(current_path).to eq pp_path
    end
  end
end
