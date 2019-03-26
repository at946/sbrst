require "rails_helper"

feature "12_ユーザーとして、結果確認ができること", type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = 1
    @answer = ["answer1", "answer2", "answer3"]
  end

  scenario "【KSページ】で【カテゴリー】が一つもない状態で【FINISHボタン】を選択した場合、【ブレスト結果ページ】へ遷移できること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)
    click_on :finish_ks_button

    expect(current_path).to eq result_path
  end

  scenario "【KSページ】で【No Category】の配下に【アンサー】が存在する状態で【FINISHボタン】を選択した場合、【ブレスト結果ページ】へ遷移できること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)
    click_on :finish_ks_button

    expect(current_path).to eq result_path

    expect(page).to have_text "No Category"
    @answer.each do |ans|
      expect(page).to have_text ans
    end
  end

  scenario "【ブレスト結果ページ】で【ブレストしたいこと】が表示されていること" do
    visit ks_path(problem: @problem, limit_time: @limit_time, answers: @answer)
    click_on :finish_ks_button

    expect(page).to have_text @problem
  end
end
