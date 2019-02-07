require 'rails_helper'

feature "11_ブレスト結果をカテゴライズできる", type: :system, js: true do
  background do
    @problem = "私たちが地球温暖化に対してできること"
    @answer1 = "公共交通機関を利用する"
    @answer2 = "クーラーの使用を控える"
    @answer3 = "植林する"
    @category1 = "カテゴリー１"
    @category2 = "カテゴリー２"
    visit root_path
    fill_in :setting_problem, with: @problem
    fill_in :setting_limit_time, with: 1
    click_on :start_brasto_button
    fill_in :answer, with: @answer1
    click_on :add_button
    fill_in :answer, with: @answer2
    click_on :add_button
    fill_in :answer, with: @answer3
    click_on :add_button
    click_on :finish_brasto_button
    page.driver.browser.switch_to.alert.accept
  end

  scenario "【ブレスト結果ページ】で【ブレスト結果アイテム】を選択した場合、一つ上に【カテゴリ】が追加されること" do
    expect(find("#result_list").all(".list-group-item").count).to eq 3
    expect(find("#result_list").all(".list-group-item")[0]).to have_text @answer1
    expect(find("#result_list").all(".list-group-item")[1]).to have_text @answer2
    expect(find("#result_list").all(".list-group-item")[2]).to have_text @answer3
    find("#result_list").all(".list-group-item")[0].click
    expect(find("#result_list").all(".list-group-item").count).to eq 4
    expect(find("#result_list").all(".list-group-item")[0]).to have_text "Category 1"
    expect(find("#result_list").all(".list-group-item")[1]).to have_text @answer1
    expect(find("#result_list").all(".list-group-item")[2]).to have_text @answer2
    expect(find("#result_list").all(".list-group-item")[3]).to have_text @answer3
    find("#result_list").all(".list-group-item")[3].click
    expect(find("#result_list").all(".list-group-item").count).to eq 5
    expect(find("#result_list").all(".list-group-item")[0]).to have_text "Category 1"
    expect(find("#result_list").all(".list-group-item")[1]).to have_text @answer1
    expect(find("#result_list").all(".list-group-item")[2]).to have_text @answer2
    expect(find("#result_list").all(".list-group-item")[3]).to have_text "Category 2"
    expect(find("#result_list").all(".list-group-item")[4]).to have_text @answer3
  end

  scenario "【ブレスト結果ページ】で【カテゴリ】をドラッグ＆ドロップで並び替えできること" do
  end

  feature "【ブレスト結果ページ】で", type: :system, js: true do
    background do
      find("#result_list").all(".list-group-item")[0].click
      find("#result_list").all(".list-group-item")[3].click
    end

    scenario "【カテゴリ】の【削除ボタン】を選択した場合、【カテゴリ】が削除されること" do
      expect(find("#result_list").all(".list-group-item").count).to eq 5
      expect(find("#result_list")).to have_text "Category 1"
      find("#result_list").all(".list-group-item")[0].find(".delete-badge").click
      expect(find("#result_list").all(".list-group-item").count).to eq 4
      expect(find("#result_list")).not_to have_text "Category 1"
    end

    feature "【カテゴリ】の【編集ボタン】を選択した場合、", type: :system, js: true do
      background do
        @category_name = find("#result_list").all(".list-group-item")[0].text
        find("#result_list").all(".list-group-item")[0].find(".edit-badge").click
      end

      scenario "【カテゴリ名更新モーダル】が表示されること" do
        expect(page).to have_selector "#category_name_modal"
      end

      scenario "【カテゴリ名更新モーダル】で【カテゴリ名】を入力できること" do
        fill_in :category_name_input, with: @category1
        sleep 10
        expect(find("#category_name_input").value).to eq @category1
      end

      scenario "【カテゴリ名更新モーダル】で【カテゴリ名】に【現在のカテゴリ名】がデフォルトで入力されること" do
        expect(find("#category_name_input").value).to eq @category_name
      end

      scenario "【カテゴリ名更新モーダル】で【Cancel】ボタンを選択した場合、【カテゴリ名更新モーダル】が閉じ、【カテゴリ名】は変更されないこと" do
        fill_in :category_name_input, with: @category1
        find("#category_name_modal_cancel").click
        expect(page).not_to have_selector "#category_name_model"
        expect(find("#result_list").all(".list-group-item")[0]).to have_text "Category 1"
        expect(find("#result_list").all(".list-group-item")[3]).to have_text "Category 2"
        find("#result_list").all(".list-group-item")[3].find(".edit-badge").click
        fill_in :category_name_input, with: ""
        find("#category_name_modal_cancel").click
        expect(find("#result_list").all(".list-group-item")[0]).to have_text "Category 1"
        expect(find("#result_list").all(".list-group-item")[3]).to have_text "Category 2"
      end

      scenario "【カテゴリ名更新モーダル】で【Save】ボタンを選択した場合、【カテゴリ名更新モーダル】が閉じ、【カテゴリ名】が更新されること" do
        fill_in :category_name_input, with: @category1
        sleep 10
        find("#category_name_modal_save").click
        expect(page).not_to have_selector "#category_name_modal"
        expect(find("#result_list").all(".list-group-item")[0]).to have_text @category1
        expect(find("#result_list").all(".list-group-item")[3]).to have_text "Category 2"
        find("#result_list").all(".list-group-item")[3].find(".edit-badge").click
        fill_in :category_name_input, with: @category2
        sleep 10
        find("#category_name_modal_save").click
        expect(find("#result_list").all(".list-group-item")[0]).to have_text @category1
        expect(find("#result_list").all(".list-group-item")[3]).to have_text @cateogry2
      end
    end
  end
end
