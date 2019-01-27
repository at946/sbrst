require 'rails_helper'

feature '01_課題を設定できること', type: :system, js: true do
  background do
    visit root_path
  end

  scenario "【トップページ】にアクセスできること" do
    expect(current_path).to eq root_path
  end

  scenario "【トップページ】で【ブレストしたいこと】を入力できること" do
    question = "このサービスの名前"
    fill_in :setting_problem, with: question
    expect(find("#setting_problem").value).to eq question
  end

end
