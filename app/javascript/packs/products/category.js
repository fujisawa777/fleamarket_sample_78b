$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    let html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChildrenBox(insertHTML){
    let childSelectHtml = '';
    childSelectHtml = `<div class="form__field" id="children">
                        <div class="form__field--input marginT25">
                          <select class="form__field--inputSelect" name="product[category_id]" id="child_category">
                            <option value="選択してください", data-category = "">選択してください</option>
                            ${insertHTML}
                          </select>
                          <i class="fas fa-angle-down form__field--inputSelectIcon">
                          </i>
                        </div>
                      </div>`;
    $('#parents').after(childSelectHtml);
  }

// 孫カテゴリーの表示作成
function appendGrandchildrenBox(insertHTML){
  let GrandchildSelectHtml = '';
  GrandchildSelectHtml = `<div class="form__field" id="grandchildren">
                            <div class="form__field--input marginT25">
                              <select class="form__field--inputSelect" name="product[category_id]" id="grandchild_category">
                                <option value="選択してください", data-category = "">選択してください</option>
                                ${insertHTML}
                              </select>
                              <i class="fas fa-angle-down form__field--inputSelectIcon">
                              </i>
                            </div>
                          </div>`;
  $('#children').after(GrandchildSelectHtml);
}

  // 親カテゴリー選択後のイベント
  $('#parents').on('change', function(){
    let parentCategory = document.getElementById('product_category_id').value;
    //選択された親カテゴリーの名前を取得
    if (parentCategory != ""){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children').remove(); //親が変更された時、子以下を削除する
        $('#grandchildren').remove();
        $('#size_wrapper').remove();
        let insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchildren').remove();
      $('#size_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $(document).on('change', '#child_category',function(){
    let childId = $('#child_category option:selected').data('category');
    console.log(childId)
    if (childId!= ""){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren').remove(); //子が変更された時、孫以下を削除するする
          $('#size_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      $('#size_wrapper').remove();
    }
  });
});