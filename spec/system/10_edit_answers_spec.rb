require 'rails_helper'

feature "10_ユーザーとして、アンサーを編集したい", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answer = ["answer1", "answer2", "answer3"]
    @new_answer = "アンサー"
  end

  scenario "【KSページ】で【アンサー】を選択した場合、【アンサー】が【編集モード】になりフォーカスされること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)

    expect(all(".answer").count).to eq @answer.count

    all(".answer")[0].click

    expect(all(".answer").count).to eq @answer.count - 1

    find("body").click
    all(".answer")[1].click

    expect(all(".answer").count).to eq @answer.count - 1

    find("body").click
    all(".answer")[2].click

    expect(all(".answer").count).to eq @answer.count - 1
  end

  scenario "【KSページ】で【編集モードのアンサー】で【Enter】を選択した場合、【アンサー】が更新されること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)

    (0...@answer.count).each do |i|
      expect(all(".answer")[i]).to have_text @answer[i]
    end

    all(".answer")[1].click

    expect(find("#answer_input").value).to eq @answer[1]

    fill_in :answer_input, with: @new_answer

    expect(find("#answer_input").value).to eq @new_answer

    find("#answer_input").native.send_keys :return

    expect(all(".answer").count).to eq @answer.count
    expect(all(".answer")[0]).to have_text @answer[0]
    expect(all(".answer")[1]).to have_text @new_answer
    expect(all(".answer")[2]).to have_text @answer[2]
    expect(all("#answer_input").count).to eq 0
  end

  scenario "【KSページ】で【編集モードのアンサー】で【フォーカスアウト】した場合、アンサーの更新がキャンセルされること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)

    (0...@answer.count).each do |i|
      expect(all(".answer")[i]).to have_text @answer[i]
    end

    all(".answer")[1].click

    expect(find("#answer_input").value).to eq @answer[1]

    fill_in :answer_input, with: @new_answer

    expect(find("#answer_input").value).to eq @new_answer

    find("body").click

    expect(all(".answer").count).to eq @answer.count
    (0...@answer.count).each do |i|
      expect(all(".answer")[i]).to have_text @answer[i]
    end
    expect(all("#answer_input").count).to eq 0
  end
end
