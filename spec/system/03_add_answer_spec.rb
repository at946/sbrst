require 'rails_helper'

feature "03_回答を登録できること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answer = ["answer1", "answer2", "answer3"]
  end

  scenario "【ブレストページ】で【answer】を入力できること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    fill_in :answer, with: @answer[0]
    expect(find("#answer").value).to eq @answer[0]
  end

  scenario "【ブレストページ】で【answer】が未入力の状態で【Enter】を選択した場合、【answer list】が追加されないこと" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    expect(page).not_to have_selector "#answer_list"

    fill_in :answer, with: ""
    find("#answer").native.send_keys :return

    expect(page).not_to have_selector "#answer_list"
    expect(find("#answer").value).to eq ""
  end

  scenario "【ブレストページ】で【answer】にスペースのみが入力された状態で【Enter】を選択した場合、【answer list】が追加されず【answer】がクリアされること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    expect(page).not_to have_selector "#answer_list"

    fill_in :answer, with: " "
    find("#answer").native.send_keys :return

    expect(page).not_to have_selector "#answer_list"
    expect(find("#answer").value).to eq ""

    fill_in :answer, with: "　"
    find("#answer").native.send_keys :return

    expect(page).not_to have_selector "#answer_list"
    expect(find("#answer").value).to eq ""

    fill_in :answer, with: "  "
    find("#answer").native.send_keys :return

    expect(page).not_to have_selector "#answer_list"
    expect(find("#answer").value).to eq ""
end

  scenario "【ブレストページ】で【answer】を入力した状態で【Enter】を選択した場合、【answer list】の１番上に入力した文字が追加され【answer】がクリアされること" do
    visit set_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: @limit_time
    click_on :start_brst_button

    expect(page).not_to have_selector "#answer_list"

    fill_in :answer, with: @answer[0]
    find("#answer").native.send_keys :return

    expect(page).to have_selector "#answer_list"
    expect(find("#answer_list").all(".card").count).to eq 1
    expect(find("#answer_list").all(".card")[0]).to have_text @answer[0]

    fill_in :answer, with: @answer[1]
    find("#answer").native.send_keys :return

    expect(page).to have_selector "#answer_list"
    expect(find("#answer_list").all(".card").count).to eq 2
    expect(find("#answer_list").all(".card")[0]).to have_text @answer[1]
    expect(find("#answer_list").all(".card")[1]).to have_text @answer[0]

    fill_in :answer, with: @answer[2]
    find("#answer").native.send_keys :return

    expect(page).to have_selector "#answer_list"
    expect(find("#answer_list").all(".card").count).to eq 3
    expect(find("#answer_list").all(".card")[0]).to have_text @answer[2]
    expect(find("#answer_list").all(".card")[1]).to have_text @answer[1]
    expect(find("#answer_list").all(".card")[2]).to have_text @answer[0]
  end
end
