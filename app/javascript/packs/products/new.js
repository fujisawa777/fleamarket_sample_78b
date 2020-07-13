$(function() {
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

  // ラベルのwidth操作
  function setLabel() {
    // 表示されている画像全部のwidthを取得
    let prevContent = $('.postContainer__label').prev().css('width').replace(/[^0-9]/g, '');
    // 全体(620px)から表示画像＋マージン分を計算して投稿ボックスのエリアを取得
    let labelWidth = (620 - parseInt(prevContent) - 5);
    // 投稿ボックスの要素のwithを変更
    $('.postContainer__label').css('width', labelWidth);
    // 投稿フォームの数をカウント
    let count = $('.preview-box').length;
    // 投稿画像が最大まであるときは、投稿ボックスを消しておく
    if (count == 5) {
      $('.postContainer__label').hide();
    }
  }

  // 配列の比較
  // 比較用元データ
  const array = [0,1,2,3,4]
  // 配列の比較メソッド（比較して、ないやつを出力）
  function diffArray(arr1, arr2) {
    return arr1.concat(arr2)
    .filter(item => !arr1.includes(item) || !arr2.includes(item));
  }

  // 配列の要素を検証し、最初の要素を返すメソッド
  function diffPrev(){
    // 現在の.previewbox内のidを取得して配列にする例)[2,3,4]
    let array_p = $('.preview-box').map(function(index, element){
        return parseInt($(element).attr("id").replace(/[^0-9]/g, ''));
      })
    array_id = $.makeArray(array_p)
    // 出力フォーマットのイニシャライズ及び出力
    let result = []
    result = diffArray(array,array_id)
    //差分の最初の要素を取得する。
    return result[0]
  }

  // ページ読み込み時に実行したい処理
  // ラベルのイニシャライズ
    setLabel();

  // チェックボックスの初期化
  if (!$(`#product_images_attributes_0__destroy`).length == 0) {
      for (let i = 0; i < 5; i++) {
        let num = String(i);
        $(`#product_images_attributes_${num}__destroy`).prop('checked',false);
        }
      }

  // 余分なinput要素の削除
  if ($(".postContainer__hiddenField").length > 5){
    let yobun = $(".postContainer__hiddenField").length - 5

    for (let i = 0 ; i < yobun ; i++) {
      $(".postContainer__hiddenField").last().remove()
  }};

  // プレビューの追加
  $(document).on('change', '.postContainer__hiddenField', function() {
    //現在のフィールドからfileのオブジェクトを取得
    let file = this.files[0];

    //postContainer__hiddenFieldのidの数値のみ取得
    let num = $(this).attr('id').replace(/[^0-9]/g, '');
    // 途中で使うファイルリーダー
    // FileReader クラスを使用すると、Blob や File オブジェクトが保有するバッファの中身に、読み取りアクセスを行う事ができます。
    let reader = new FileReader();


    // 編集用の分岐。チェックがついてたらチェックを消す
    if($(`#product_images_attributes_${num}__destroy`).prop("checked")){
      $(`#product_images_attributes_${num}__destroy`).prop('checked',false)
    }

    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);

    //読み込み時に発火するイベント
    reader.onload = function() {
      //読み込んだイメージを格納
      let image = this.result;

      //プレビューが元々なかった場合はhtmlを追加
      if ($(`#preview-box__${num}`).length == 0) {
        // htmlを定義する
        let html = buildHTML(num);

        //ラベルの直前のプレビュー群にプレビューを追加
        let prevContent = $('.postContainer__label').prev();
        $(prevContent).append(html);
      }

      //イメージを追加
      $(`#preview-box__${num} img`).attr({
                                          src: `${image}`,
                                          class: "upper-box__image"
                                          });

      //ラベルのwidth操作
      setLabel();

      // 投稿されてないフォームの最初のidを取得
      let id = diffPrev()

      //labelボックスのidとforを更新
      $('.postContainer__labelBox').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_src`});
    }
  });


  // 画像の削除
  $(document).on('click', '.delete-box', function() {

    //product_images_attributes_${id}_image から${id}に入った数字のみを抽出
    let num = parseInt($(this).attr('id').replace(/[^0-9]/g, ''));
    //取得したidに該当するプレビューを削除
    $(`#preview-box__${num}`).remove();
    //サイズの再計算
    setLabel();

      //新規登録時と編集時の場合分け==========================================================
      //新規投稿時
      //削除用チェックボックスの有無で判定
      if ($(`#product_images_attributes_${num}__destroy`).length == 0) {

        //フォームの中身を削除
        $(`#product_images_attributes_${num}_src`).val("");

        let count = $('.preview-box').length;

        //5個めが消されたらラベルを表示
        if (count == 4) {
          $('.postContainer__label').show();
        }

        setLabel();

        // 投稿されてないフォームの最初のidを取得
        let id = diffPrev()

        //labelボックスのidとforを更新
        $('.postContainer__labelBox').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_src`});
      } else {
        //投稿編集時
        $(`#product_images_attributes_${num}__destroy`).prop('checked',true);
          let count = $('.preview-box').length;

        //5個めが消されたらラベルを表示
          if (count == 4) {
            $('.postContainer__label').show();
          }

        //ラベルのwidth操作
        setLabel();

        // 投稿されてないフォームの最初のidを取得
        let id = diffPrev()

        //labelボックスのidとforを更新
        $('.postContainer__labelBox').attr({id: `label-box--${id}`,for: `product_images_attributes_${id}_src`});
        }
      })
  });
