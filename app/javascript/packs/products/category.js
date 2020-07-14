$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    let html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    let childSelectHtml = '';
    childSelectHtml = `<div class="form__field marginT25" id="children">
                        <div class="form__field--input marginT25">
                          <select class="form__field--inputSelect" name="product[category_id]" id="product_category_id">
                            <option value="">選択してください</option>
                            ${insertHTML}
                          </select>
                          <i class="fas fa-angle-down form__field--inputSelectIcon">
                          </i>
                        </div>
                      </div>`;
    $('#parents').after(childSelectHtml);
  }

// 孫カテゴリーの表示作成
// function appendGrandchidrenBox(insertHTML){
//   let childSelectHtml = '';
//   childSelectHtml = `<div class="form__field marginT25" id="grandchildren">
//                       <div class="form__field--input marginT25">
//                         <select class="form__field--inputSelect" name="product[category_id]" id="product_category_id">
//                           <option value="">選択してください</option>
//                           ${insertHTML}
//                         </select>
//                         <i class="fas fa-angle-down form__field--inputSelectIcon">
//                         </i>
//                       </div>
//                     </div>`;
//   $('#children').append(grandchildSelectHtml);
// }

  // 親カテゴリー選択後のイベント
  $('.form__field--input').on('change', function(){
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
        $('#grandchildren_wrapper').remove();
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
        let insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchildren_wrapper').remove();
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  // $('.form__field--input').on('change', function(){
  //   let childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
  //   if (childId != ""){ //子カテゴリーが初期値でないことを確認
  //     $.ajax({
  //       url: 'get_category_grandchildren',
  //       type: 'GET',
  //       data: { grandchild_id: grandchildId },
  //       dataType: 'json'
  //     })
  //     .done(function(grandchildren){
  //       if (grandchildren.length != 0) {
  //         $('#grandchildren').remove(); //子が変更された時、孫以下を削除するする
  //         $('#size_wrapper').remove();
  //         $('#brand_wrapper').remove();
  //         var insertHTML = '';
  //         grandchildren.forEach(function(grandchild){
  //           insertHTML += appendOption(grandchild);
  //         });
  //         appendGrandchidrenBox(insertHTML);
  //       }
  //     })
  //     .fail(function(){
  //       alert('カテゴリー取得に失敗しました');
  //     })
  //   }else{
  //     $('#grandchildren').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
  //     $('#size_wrapper').remove();
  //     $('#brand_wrapper').remove();
  //   }
  // });
});