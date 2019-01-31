require 'rails_helper'

feature "04_回答を登録できること", type: :system, js: true do
  background do
    @answer1 = "公共交通機関を利用する"
    @answer2 = "クーラーの使用を控える"
    visit root_path
    fill_in :setting_problem, with: "私たちが地球温暖化に対してできること"
    fill_in :setting_limit_time, with: 10
    click_on :start_brasto_button
  end

  scenario "【ブレストページ】で【answer】を入力できること" do
    fill_in :answer, with: @answer1
    expect(find("#answer").value).to eq @answer1
  end

  scenario "【ブレストページ】で【answer】が未入力の状態で【＋】を選択した場合、【answer list】が追加されないこと" do
    expect(current_path).to eq run_path
    expect(find("#answer_list").all("li").count).to eq 0
    fill_in :answer, with: ""
    click_on :add_button
    expect(find("#answer_list").all("li").count).to eq 0
    expect(find("#answer").value).to eq ""
  end

  scenario "【ブレストページ】で【answer】にスペースのみが入力された状態で【＋】を選択した場合、【answer list】が追加されず【answer】がクリアされること" do
    expect(current_path).to eq run_path
    expect(find("#answer_list").all("li").count).to eq 0
    fill_in :answer, with: "　　　"
    click_on :add_button
    expect(find("#answer_list").all("li").count).to eq 0
    expect(find("#answer").value).to eq ""
    fill_in :answer, with: "   "
    click_on :add_button
    expect(find("#answer_list").all("li").count).to eq 0
    expect(find("#answer").value).to eq ""
  end

  scenario "【ブレストページ】で【answer】を入力した状態で【＋】を選択した場合、【answer list】の１番上に入力した文字が追加され【answer】がクリアされること" do
    expect(current_path).to eq run_path
    expect(find("#answer_list").all("li").count).to eq 0
    fill_in :answer, with: @answer1
    click_on :add_button
    expect(find("#answer_list").all("li").count).to eq 1
    expect(find("#answer_list").all("li")[0]).to have_text @answer1
    expect(find("#answer").value).to eq ""
    fill_in :answer, with: @answer2
    click_on :add_button
    expect(find("#answer_list").all("li").count).to eq 2
    expect(find("#answer_list").all("li")[0]).to have_text @answer2
    expect(find("#answer_list").all("li")[1]).to have_text @answer1
    expect(find("#answer").value).to eq ""
  end
end
