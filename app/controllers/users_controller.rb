class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    # ウィザード形式のエラー分岐（sessionの保持の値によってレンダリングを分岐させる）
    # ウィザード形式の際に戻るボタンを押すことによるエラーを防ぐため実装
    # .nil?メソッド値がnilならtrueを返す。
    # 条件
    # session["devise.regist_data"]["user"].nil?
    # session["devise.regist_data"]["personal"].nil?
    # sessonデータがなかった場合(通常のuser処理)
    if session["devise.regist_data"].nil?
      #トップページへ戻らせる
      redirect_to root_path
    # sessionデータがuserとpersonalがあった場合
    elsif !session["devise.regist_data"]["personal"].nil?
      redirect_to sendaddresses_path

    # sessionデータがuserだけあった場合
    elsif !session["devise.regist_data"]["user"].nil?
      redirect_to personals_path
    end
  end

  def mypage
    @user = User.find(current_user.id)
  end

  def logout
  end
end
