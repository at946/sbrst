require "rails_helper"

feature "11_ユーザーとしてアンサーを削除したい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answer = ["answer1", "answer2", "answer3"]
  end

  scenario "【KSページ】で【アンサーの削除アイコン】を選択した場合、【アンサー削除ダイアログ】が表示されること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)
    all(".answer")[0].find(".delete-answer").click
    page.driver.browser.switch_to.alert.dismiss

    expect(all(".delete-answer").count).to eq @answer.count
    all(".answer")[0].find("span").click
    expect(all(".delete-answer").count).to eq @answer.count - 1
    find("body").click
    expect(all(".delete-answer").count).to eq @answer.count

    all(".answer")[0].find(".delete-answer").click
    page.driver.browser.switch_to.alert.dismiss
  end

  scenario "【アンサー削除ダイアログ】で【'answer'を削除しますか？】と表示されること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)
    all(".answer")[0].find(".delete-answer").click
    expect(page.driver.browser.switch_to.alert.text).to eq "'#{@answer[0]}'を削除しますか？"
    page.driver.browser.switch_to.alert.dismiss

    expect(all(".delete-answer").count).to eq @answer.count
    all(".answer")[0].find("span").click
    expect(all(".delete-answer").count).to eq @answer.count - 1
    find("body").click
    expect(all(".delete-answer").count).to eq @answer.count

    all(".answer")[0].find(".delete-answer").click
    expect(page.driver.browser.switch_to.alert.text).to eq "'#{@answer[0]}'を削除しますか？"
    page.driver.browser.switch_to.alert.dismiss
  end

  scenario "【アンサー削除ダイアログ】で【キャンセル】を選択した場合、アンサーが削除されないこと" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)
    expect(all(".answer").count).to eq @answer.count
    all(".answer")[0].find(".delete-answer").click
    page.driver.browser.switch_to.alert.dismiss
    expect(all(".answer").count).to eq @answer.count

    expect(all(".delete-answer").count).to eq @answer.count
    all(".answer")[0].find("span").click
    expect(all(".delete-answer").count).to eq @answer.count - 1
    find("body").click
    expect(all(".delete-answer").count).to eq @answer.count

    expect(all(".answer").count).to eq @answer.count
    all(".answer")[0].find(".delete-answer").click
    page.driver.browser.switch_to.alert.dismiss
    expect(all(".answer").count).to eq @answer.count
  end

  scenario "【アンサー削除ダイアログ】で【OK】を選択した場合、アンサーが削除されること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)
    expect(all(".answer").count).to eq @answer.count
    all(".answer")[0].find(".delete-answer").click
    page.driver.browser.switch_to.alert.accept
    expect(all(".answer").count).to eq @answer.count - 1

    expect(all(".delete-answer").count).to eq @answer.count - 1
    all(".answer")[0].find("span").click
    expect(all(".delete-answer").count).to eq @answer.count - 2
    find("body").click
    expect(all(".delete-answer").count).to eq @answer.count - 1

    expect(all(".answer").count).to eq @answer.count - 1
    all(".answer")[0].find(".delete-answer").click
    page.driver.browser.switch_to.alert.accept
    expect(all(".answer").count).to eq @answer.count - 2
  end
end
