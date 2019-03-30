require "rails_helper"

feature "11_ユーザーとしてアンサーを削除したい", type: :system, js: true do
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

    scenario "【アンサーの削除アイコン】を選択した場合、【アンサー削除ダイアログ】が表示されること" do
      all(".answer")[0].find(".delete-answer").click
      page.driver.browser.switch_to.alert.dismiss

      expect(all(".delete-answer").count).to eq @answers.count
      all(".answer")[0].find(".edit-answer").click
      expect(all(".delete-answer").count).to eq @answers.count - 1
      find("body").click
      expect(all(".delete-answer").count).to eq @answers.count

      all(".answer")[0].find(".delete-answer").click
      page.driver.browser.switch_to.alert.dismiss
    end

    scenario "【アンサー削除ダイアログ】で【'answer'を削除しますか？】と表示されること" do
      all(".answer")[0].find(".delete-answer").click
      expect(page.driver.browser.switch_to.alert.text).to eq "'#{@answers[0]}'を削除しますか？"
      page.driver.browser.switch_to.alert.dismiss

      expect(all(".delete-answer").count).to eq @answers.count
      all(".answer")[0].find(".edit-answer").click
      expect(all(".delete-answer").count).to eq @answers.count - 1
      find("body").click
      expect(all(".delete-answer").count).to eq @answers.count

      all(".answer")[0].find(".delete-answer").click
      expect(page.driver.browser.switch_to.alert.text).to eq "'#{@answers[0]}'を削除しますか？"
      page.driver.browser.switch_to.alert.dismiss
    end

    scenario "【アンサー削除ダイアログ】で【キャンセル】を選択した場合、アンサーが削除されないこと" do
      expect(all(".answer").count).to eq @answers.count
      all(".answer")[0].find(".delete-answer").click
      page.driver.browser.switch_to.alert.dismiss
      expect(all(".answer").count).to eq @answers.count

      expect(all(".delete-answer").count).to eq @answers.count
      all(".answer")[0].find(".edit-answer").click
      expect(all(".delete-answer").count).to eq @answers.count - 1
      find("body").click
      expect(all(".delete-answer").count).to eq @answers.count

      expect(all(".answer").count).to eq @answers.count
      all(".answer")[0].find(".delete-answer").click
      page.driver.browser.switch_to.alert.dismiss
      expect(all(".answer").count).to eq @answers.count
    end

    scenario "【アンサー削除ダイアログ】で【OK】を選択した場合、アンサーが削除されること" do
      expect(all(".answer").count).to eq @answers.count
      all(".answer")[0].find(".delete-answer").click
      page.driver.browser.switch_to.alert.accept
      expect(all(".answer").count).to eq @answers.count - 1

      expect(all(".delete-answer").count).to eq @answers.count - 1
      all(".answer")[0].find(".edit-answer").click
      expect(all(".delete-answer").count).to eq @answers.count - 2
      find("body").click
      expect(all(".delete-answer").count).to eq @answers.count - 1

      expect(all(".answer").count).to eq @answers.count - 1
      all(".answer")[0].find(".delete-answer").click
      page.driver.browser.switch_to.alert.accept
      expect(all(".answer").count).to eq @answers.count - 2
    end
  end
end
