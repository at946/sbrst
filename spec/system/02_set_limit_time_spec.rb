require 'rails_helper'

feature "02_制限時間を設定できること", type: :system, js: true do
  background do
    visit root_path
  end

  scenario "【トップページ】で【ブレストする時間】に数字を入力できること" do
    fill_in :setting_limit_time, with: 20
    expect(find("#setting_limit_time").value).to eq "20"
  end

  scenario "【トップページ】で【ブレストする時間】に数字以外を入力できないこと" do
    fill_in :setting_limit_time, with: "こんにちは、世界"
    expect(find("#setting_limit_time").value).to eq ""
    fill_in :setting_limit_time, with: "Hello, World."
    expect(find("#setting_limit_time").value).to eq ""
  end
end
