require 'rails_helper'

feature '01_トップページにアクセスできること', type: :system, js: true do
  background do
    @problem = "Sample Problem"
    @limit_time = "1"
    @answers = ["answer1", "answer2", "answer3"]
  end

  scenario "【トップページ】にダイレクトアクセスできること" do
    visit root_path
    expect(current_path).to eq root_path
  end

  scenario "【利用規約ページ】で【ヘッダー】の【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
    visit tos_path
    expect(current_path).to eq tos_path
    click_on :logo
    expect(current_path).to eq root_path
  end

  scenario "【プライバシーポリシーページ】で【ヘッダー】の【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
    visit pp_path
    expect(current_path).to eq pp_path
    click_on :logo
    expect(current_path).to eq root_path
  end

  scenario "【ブレスト設定ページ】で【ヘッダー】の【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
    visit root_path
    click_on :brst_start_first_button
    expect(current_path).to eq set_path
    click_on :logo
    expect(current_path).to eq root_path
  end

  scenario "【ブレストページ】で【ヘッダー】の【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
    visit root_path
    click_on :brst_start_first_button
    fill_in :problem, with: @problem
    fill_in :limit_time, with: @limit_time
    click_on :start_brst_button

    expect(current_path).to eq brst_path

    click_on :logo

    expect(current_path).to eq root_path
  end

  scenario "【ブレスト失敗ページ】で【ヘッダー】の【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
    visit root_path
    click_on :brst_start_first_button
    fill_in :problem, with: @problem
    fill_in :limit_time, with: @limit_time
    click_on :start_brst_button

    sleep 65

    expect(current_path).to eq result_path
    expect(page).to have_text "RETRY"

    click_on :logo

    expect(current_path).to eq root_path
  end

  scenario "【ブレスト結果ページ】で【ヘッダー】の【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
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

    expect(current_path).to eq result_path
    expect(page).to have_text "RESULT SHARE"

    click_on :logo

    expect(current_path).to eq root_path
  end

  scenario "【ブレストまとめページ】で【ヘッダー】の【ロゴ】を選択した場合、【トップページ】へ遷移すること" do
    # 【トップページ】にアクセスする
    visit root_path
    # 【トップページ】で【ブレストを始めるボタン】を選択して、【ブレスト設定ページ】へ遷移する
    click_on :brst_start_first_button
    # 【ブレスト設定ページ】で【ブレストしたいこと】に@problemを入力する
    fill_in :problem, with: @problem
    # 【ブレスト設定ページ】で【制限時間】に@limit_timeを入力する
    fill_in :limit_time, with: @limit_time
    # 【ブレスト設定ページ】で【STARTボタン】を選択して、【ブレストページ】へ遷移する
    click_on :start_brst_button
    # 【ブレストページ】で【アンサー】に@answersを１つずつ登録する
    @answers.each do |ans|
      fill_in :answer, with: ans
      find("#answer").native.send_keys :return
    end
    # 【ブレストページ】で【ブレスト完了ボタン】を選択して、【ブレスト完了ダイアログ】を表示する
    click_on :finish_brst_button
    # 【ブレスト完了ダイアログ】で【OK】を選択し、【ブレスト完了ページ】へ遷移する
    page.driver.browser.switch_to.alert.accept
    # 【ブレスト完了ページ】で【まとめリンクボタン】を選択して、【ブレストまとめページ】へ遷移する
    click_on :matome_link

    ########## 現在のページが【ブレストまとめページ】であること
    expect(current_path).to eq matome_path

    # 【ブレストまとめページ】で【ロゴ】を選択する
    click_on :logo

    ########## 現在のページが【トップページ】であること
    expect(current_path).to eq root_path
  end
end
