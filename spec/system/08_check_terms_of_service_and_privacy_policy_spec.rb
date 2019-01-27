require 'rails_helper'

feature "08_利用規約とプライバシーポリシーを確認したい", type: :system, js: true do
  background do
    @problem = "私たちが地球温暖化に対してできること"
    @answer1 = "公共交通機関を利用する"
    @answer2 = "クーラーの使用を控える"
    visit root_path
  end

  feature "【トップページ】で", type: :system, js: true do
    scenario "【トップ】を選択した場合、【トップページ】へ遷移すること" do
      find("#fmenu_to_top").click
      expect(current_path).to eq root_path
    end

    scenario "【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      find("#fmenu_to_tos").click
      expect(current_path).to eq terms_of_service_path
    end

    scenario "【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      find("#fmenu_to_pp").click
      expect(current_path).to eq privacy_policy_path
    end
  end

  feature "【ブレストページ】で", type: :system, js: true do
    background do
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: 1
      click_on :start_brasto_button
    end

    scenario "【フッターメニュー】に【トップ】が表示されないこと" do
      expect(page).not_to have_selector("#fmenu_to_top")
    end

    scenario "【フッターメニュー】に【利用規約】が表示されないこと" do
      expect(page).not_to have_selector("#fmenu_to_tos")
    end

    scenario "【フッターメニュー】に【プライバシーポリシー】が表示されないこと" do
      expect(page).not_to have_selector("#fmenu_to_pp")
    end
  end


  feature "【ブレスト結果ページ】で", type: :system, js: true do
    background do
      fill_in :setting_problem, with: @problem
      fill_in :setting_limit_time, with: 1
      click_on :start_brasto_button
      click_on :finish_brasto_button
      page.driver.browser.switch_to.alert.accept
    end

    scenario "【トップ】を選択した場合、【トップページ】へ遷移すること" do
      find("#fmenu_to_top").click
      expect(current_path).to eq root_path
    end

    scenario "【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      find("#fmenu_to_tos").click
      expect(current_path).to eq terms_of_service_path
    end

    scenario "【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      find("#fmenu_to_pp").click
      expect(current_path).to eq privacy_policy_path
    end
  end

  scenario "【利用規約ページ】に直接アクセスできること" do
    visit terms_of_service_path
    expect(current_path).to eq terms_of_service_path
  end

  feature "【利用規約ページ】で", type: :system, js: true do
    background do
      visit terms_of_service_path
    end

    scenario "【トップ】を選択した場合、【トップページ】へ遷移すること" do
      find("#fmenu_to_top").click
      expect(current_path).to eq root_path
    end

    scenario "【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
      find("#logo").click
      expect(current_path).to eq root_path
    end

    scenario "【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      find("#fmenu_to_tos").click
      expect(current_path).to eq terms_of_service_path
    end

    scenario "【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      find("#fmenu_to_pp").click
      expect(current_path).to eq privacy_policy_path
    end
  end

  scenario "【プライバシーポリシーページ】に直接アクセスできること" do
    visit privacy_policy_path
    expect(current_path).to eq privacy_policy_path
  end

  feature "【プライバシーポリシーページ】で", type: :system, js: true do
    background do
      visit privacy_policy_path
    end

    scenario "【トップ】を選択した場合、【トップページ】へ遷移すること" do
      find("#fmenu_to_top").click
      expect(current_path).to eq root_path
    end

    scenario "【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
      find("#logo").click
      expect(current_path).to eq root_path
    end

    scenario "【利用規約】を選択した場合、【利用規約ページ】へ遷移すること" do
      find("#fmenu_to_tos").click
      expect(current_path).to eq terms_of_service_path
    end

    scenario "【プライバシーポリシー】を選択した場合、【プライバシーポリシーページ】へ遷移すること" do
      find("#fmenu_to_pp").click
      expect(current_path).to eq privacy_policy_path
    end
  end
end
