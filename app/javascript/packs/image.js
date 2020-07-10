// $(document).on('turbolinks:load', ()=> {
 // 画像用のinputを生成する関数

// }
// // プレビュー用のimgタグを生成する関数
// const buildImg = (index, url)=> {
//   const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
//   return html;
// }

// // file_fieldのnameに動的なindexをつける為の配列
// let fileIndex = [1,2,3,4,5,6,7,8,9,10];
// // 既に使われているindexを除外
// lastIndex = $('.js-file_group:last').data('index');
// fileIndex.splice(0, lastIndex);
// if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));

// $('.hidden-destroy').hide();

// $('#image-box').on('change', '.js-file', function(e) {
//   const targetIndex = $(this).parent().data('index');
//   // ファイルのブラウザ上でのURLを取得する
//   const file = e.target.files[0];
//   const blobUrl = window.URL.createObjectURL(file);

//   // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
//   if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
//     img.setAttribute('src', blobUrl);
//   } else {  // 新規画像追加の処理
//     $('#previews').append(buildImg(targetIndex, blobUrl));
//     // fileIndexの先頭の数字を使ってinputを作る
//     $('#image-box').append(buildFileField(fileIndex[0]));
//     fileIndex.shift();
//     // 末尾の数に1足した数を追加する
//     fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
//   }
// });

// $('#image-box').on('click', '.js-remove', function() {
//   const targetIndex = $(this).parent().data('index');
//   // 該当indexを振られているチェックボックスを取得する
//   const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
//   // もしチェックボックスが存在すればチェックを入れる
//   if (hiddenCheck) hiddenCheck.prop('checked', true);

//   $(this).parent().remove();
//   $(`img[data-index="${targetIndex}"]`).remove();

//   // 画像入力欄が0個にならないようにしておく
//   if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
//   });
// });

$(document).on('turbolinks:load', () => {

  //プレビューのhtmlを定義
  function buildHTML(id) {
    let html = `<div class="preview-box" id="preview-box__${id}">
                  <div class="upper-box">
                    <img src="" alt="preview">
                  </div>
                  <div class="lower-box">
                    <div class="update-box">
                      <label for="product_images_attributes_${id}_src",class="edit_btn">編集</label>
                    </div>
                    <div class="delete-box" id="delete_btn_${id}">
                      <span>削除</span>
                    </div>
                  </div>
                </div>`
    return html;
  }

  const input = ` <input class="postContainer__hiddenField" type="file" name="product[images_attributes][0][src]" id="product_images_attributes_0_src">
                  <input class="postContainer__hiddenField" id="product_images_attributes_1_src" name="product[images_attributes][1][src]" type="file">
                  <input class="postContainer__hiddenField" id="product_images_attributes_2_src" name="product[images_attributes][2][src]" type="file">
                  <input class="postContainer__hiddenField" id="product_images_attributes_3_src" name="product[images_attributes][3][src]" type="file">
                  <input class="postContainer__hiddenField" id="product_images_attributes_4_src" name="product[images_attributes][4][src]" type="file">`

  // ラベルのwidth操作
  function setLabel() {
    let prevContent = $('.postContainer__label').prev().css('width').replace(/[^0-9]/g, '');
    let labelWidth = (620 - parseInt(prevContent) - 5);
    $('.postContainer__label').css('width', labelWidth);
  }

  if ($('.postContainer__hiddenField').length == 0) $('.postContainer__hidden').append(input);


  // プレビューの追加
  $(document).on('change', '.postContainer__hiddenField', function() {
    setLabel();
    //postContainer__hiddenFieldのidの数値のみ取得
    let id = $(this).attr('id').replace(/[^0-9]/g, '');

    //labelボックスのidとforを更新
    $('.postContainer__labelBox').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_src`});
    //現在のフィールドからfileのオブジェクトを取得
    let file = this.files[0];
    // 途中で使うファイルリーダー
    // FileReader クラスを使用すると、Blob や File オブジェクトが保有するバッファの中身に、読み取りアクセスを行う事ができます。
    let reader = new FileReader();
    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);
    //読み込み時に発火するイベント
    reader.onload = function() {
      //読み込んだイメージを格納
      let image = this.result;
      //プレビューが元々なかった場合はhtmlを追加
      if ($(`#preview-box__${id}`).length == 0) {
        let count = $('.preview-box').length;
        // htmlを定義する
        let html = buildHTML(id);
        //ラベルの直前のプレビュー群にプレビューを追加
        let prevContent = $('.postContainer__label').prev();
        $(prevContent).append(html);
      }
      //イメージを追加
      $(`#preview-box__${id} img`).attr({
                                          src: `${image}`,
                                          class: "upper-box__image"
                                          });
      let count = $('.preview-box').length;

      //プレビューが5個あったらラベルを隠す
      if (count == 5) {
        $('.postContainer__label').hide();
      }

      //ラベルのwidth操作
      setLabel();

      //ラベルのidとforの値を変更
      if(count < 5){
        //プレビューの数でラベルのオプションを更新する(バグあり)
        $('.postContainer__labelBox').attr({id: `label-box--${count}`,for: `product_images_attributes_${count}_src`});
      }
    }
  });

  // 画像の削除
  $(document).on('click', '.delete-box', function() {
    //product_images_attributes_${id}_image から${id}に入った数字のみを抽出
    let id = parseInt($(this).attr('id').replace(/[^0-9]/g, ''));
    //取得したidに該当するプレビューを削除
    $(`#preview-box__${id}`).remove();
    //サイズの再計算
    setLabel();
    //フォームの中身を削除
    $(`#product_images_attributes_${id}_src`).val("");
    // コンテンツの数を計算する
    let count = $('.preview-box').length;

    //5個めが消されたらラベルを表示
    if (count == 4) {
      $('.postContainer__label').show();
      setLabel();
    }

    if(id < 5){
      //削除された際に、空っぽになったfile_fieldをもう一度入力可能にする
      $('.postContainer__labelBox').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_src`});
    }
  });
});