require 'rails_helper'

feature "05_制限時間がすぎる前にブレストを終了できること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answers = ["answer1", "answer2", "answer3"]
  end

  feature "【ブレストページ】で", type: :system, js: true do
    background do
      # 【トップページ】にアクセスする
      visit root_path
      # 【BRST_START_FIRST_BUTTON】をクリックして、【ブレスト設定ページ】へ遷移する
      click_on :brst_start_first_button
      # 【ブレストしたいこと】に@problemを入力する
      fill_in :problem, with: @problem
      # 【制限時間】に@limit_timeを入力する
      fill_in :limit_time, with: @limit_time
      # 【START_BRST_BUTTON】をクリックして、【ブレストページ】へ遷移する
      click_on :start_brst_button
    end

    scenario "【アンサー】がない場合、【FINISH_BRST_BUTTON】を選択できないこと" do
      find("#finish_brst_button").disabled?
    end

    scenario "【アンサー】がある状態で、【FINISH_BRST_BUTTON】を選択した場合、【ブレスト完了確認ダイアログ】が表示されること" do
      @answers.each do |ans|
        fill_in :answer, with: ans
        find("#answer").native.send_keys :return
      end
      click_on :finish_brst_button
      page.driver.browser.switch_to.alert.dismiss
    end

    feature "【ブレスト完了確認ダイアログ】で", type: :system, js: true do
      background do
        @answers.each do |ans|
          fill_in :answer, with: ans
          find("#answer").native.send_keys :return
        end
        click_on :finish_brst_button
      end

      scenario "「ブレストを完了しますか？」と表示されること" do
        expect(page.driver.browser.switch_to.alert.text).to eq "ブレストを完了しますか？"
        page.driver.browser.switch_to.alert.dismiss
      end

      scenario "【キャンセル】を選択した場合、【ブレスト完了確認ダイアログ】が閉じること" do
        page.driver.browser.switch_to.alert.dismiss
        expect(current_path).to eq brst_path
      end

      scenario "【OK】を選択した場合、【まとめページ】へ遷移すること" do
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq result_path
      end
    end
  end

  feature "【まとめページ】で", type: :system, js: true do
    background do
      visit root_path
      click_on :brst_start_first_button
      fill_in :problem, with: @problem
      fill_in :limit_time, with: @limit_time
      click_on :start_brst_button
      @answers.each do |ans|
        fill_in :answer, with: ans
        find("#answer").native.send_keys :return
      end
      click_on :finish_brst_button
      page.driver.browser.switch_to.alert.accept
    end

    scenario "【ブレスト設定ページ】で設定した【ブレストしたい課題】が表示されること" do
      expect(current_path).to eq result_path
      expect(page).to have_text @problem
    end

    scenario "【ブレストページ】で追加した【アンサー】が表示されること" do
      expect(current_path).to eq result_path
      @answers.each do |ans|
        expect(page).to have_text ans
      end
    end
  end
end
