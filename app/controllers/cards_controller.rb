class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card
  before_action :set_secretkey, only: [:create, :destroy]

  def index
    @cards = Card.all
  end

  def new # カードの登録画面。送信ボタンを押すとcreateアクションへ。
    redirect_to action: "index" if @card.present?
  end


  def create #PayjpとCardのデータベースを作成
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      #トークンが正常に発行されていたら、顧客情報をPAY.JPに登録します。
      customer = Payjp::Customer.create(card: params['payjp-token'])
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def destroy
    if !@card.blank? && @card.user_id == current_user.id
        customer = Payjp::Customer.retrieve(@card.customer_id)
        customer.delete
        @card.delete
        flash[:notice] = 'カードが削除されました'
        redirect_to action: "index"
      else
        flash.now[:notice]  = 'カードが削除されませんでした'
        redirect_to action: "index"
      end
  end

  def pay
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

  def set_secretkey
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
  end
end
