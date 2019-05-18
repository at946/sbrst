feature "18_他人の知恵も借りたいユーザーとして、URLを共有して他人にブレストさせたい、なぜなら自分では考えつかないアイデアに出会えるかもしれないからだ", type: :system, js: true do
  background do
    @problem = "ブレストしたいことを書く"
    @limit_time = 10
  end

  feature "【ブレスト設定ページ】で、", type: :system, js: true do
    background do
      visit set_path
    end

    scenario "【ブレストしたいこと】が未入力の状態で、
    【ブレストを共有する】を選択した場合、「ブレストしたいことを入力してください」とエラーが表示されること" do
      fill_in :problem, with: ""
      fill_in :limit_time, with: @limit_time
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).to have_text "ブレストしたいことを入力してください"
    end

    scenario "【ブレスト設定ページ】で、【ブレストしたいこと】がスペースのみの状態で、
    【ブレストを共有する】を選択した場合、「ブレストしたいことを入力してください」とエラーが表示されること" do
      fill_in :problem, with: " "
      fill_in :limit_time, with: @limit_time
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).to have_text "ブレストしたいことを入力してください"
      expect(find("#problem").value).to eq ""

      fill_in :problem, with: "　"
      fill_in :limit_time, with: @limit_time
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).to have_text "ブレストしたいことを入力してください"
      expect(find("#problem").value).to eq ""

      fill_in :problem, with: " 　"
      fill_in :limit_time, with: @limit_time
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).to have_text "ブレストしたいことを入力してください"
      expect(find("#problem").value).to eq ""
    end

    scenario "【制限時間】が未入力の状態で、【ブレストを共有する】を選択した場合、「制限時間を入力してください」とエラーが表示されること" do
      fill_in :problem, with: @problem
      fill_in :limit_time, with: ""
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).to have_text "制限時間を入力してください"
      expect(find("#limit_time").value).to eq ""
    end

    scenario "【制限時間】が１分未満の状態で、【ブレストを共有する】を選択した場合、「制限時間は1~30分の間で入力してください」とエラーが表示されること" do
      fill_in :problem, with: @problem
      fill_in :limit_time, with: 0
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).to have_text "制限時間は1~30分の間で入力してください"
      expect(find("#limit_time").value).to eq "0"

      fill_in :limit_time, with: 1
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).not_to have_text "制限時間は1~30分の間で入力してください"
    end

    scenario "【制限時間】が３０分より長い状態で、【ブレストを共有する】を選択した場合、「制限時間は1~30分の間で入力してください」とエラーが表示されること" do
      fill_in :problem, with: @problem
      fill_in :limit_time, with: 31
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).to have_text "制限時間は1~30分の間で入力してください"
      expect(find("#limit_time").value).to eq "31"

      fill_in :limit_time, with: 30
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).not_to have_text "制限時間は1~30分の間で入力してください"
    end

    scenario "【ブレストを共有する】を選択した場合、【ブレスト設定共有ページ】へ遷移すること" do
      fill_in :problem, with: @problem
      fill_in :limit_time, with: @limit_time
      click_on :share_set_link
      expect(current_path).to eq share_set_path
      expect(page).to have_text "Share setting"
    end
  end

  feature "【ブレスト設定共有ページ】で、", type: :system, js: true do
    background do
      visit share_set_path(problem: @problem, limit_time: @limit_time)
    end

    scenario "【ブレストしたいこと】が表示されていること" do
      expect(find("#problem").value).to eq @problem
    end

    scenario "【制限時間】が表示されていること" do
      expect(find("#limit_time").value).to eq @limit_time.to_s
    end

    scenario "【URL】が表示されていること" do
      expect(find("#url").value).to eq "https://www.toriaezu-brasto.tk#{brst_path}?problem=#{@problem}&limit_time=#{@limit_time}"
    end

    scenario "【戻る】を選択した場合、【ブレスト設定ページ】へ遷移すること" do
      click_on :back_button
      expect(current_path).to eq set_path
    end
  end

  feature "【ブレスト設定共有ページ】から【ブレスト設定ページ】へ戻るとき、", type: :system, js: true do
    background do
      visit set_path
      fill_in :problem, with: @problem
      fill_in :limit_time, with: @limit_time
      click_on :share_set_link
      click_on :back_button
    end

    scenario "【ブレストしたいこと】にデフォルトで【設定していたブレストしたいこと】が入力されていること" do
      expect(find("#problem").value).to eq @problem
    end

    scenario "【制限時間】にデフォルトで【制限時間】が入力されていること" do
      expect(find("#limit_time").value).to eq @limit_time.to_s
    end
  end
end
