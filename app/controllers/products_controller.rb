class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :buy]
  before_action :set_parents, only: [:new, :edit, :create , :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # 売り切れを除く商品全て
    # 売り切れ＝buyer_idがnilではない
    @products = Product.where(buyer: nil).includes(:images).order('created_at DESC')
  end

  def show
  end

  def new
    @product = Product.new
    @product.images.new
  end

  # 以下全て、formatはjsonのみ
  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find(params[:parent_id]).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find(params[:child_id]).children
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = '商品が出品されました'
      redirect_to root_path
    else
      @product.images.new
      flash.now[:alert]  = 'エラーがあります'
      render :new
    end
  end

  def edit
    if !(@product.seller_id == current_user.id)
      redirect_to root_path
    end
  end

  def update
    if @product.seller_id == current_user.id && @product.update(product_params)
      flash[:notice] = '商品が更新されました'
      redirect_to root_path
    else
      flash.now[:alert]  = '商品の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    if @product.seller_id == current_user.id && @product.destroy
        flash[:notice] = '商品が削除されました'
        redirect_to root_path
    else
      flash.now[:alert]  = '商品が削除されませんでした'
      redirect_to root_path
    end
  end

  def buy
    @card = Card.find_by(user_id: current_user.id) if Card.find_by(user_id: current_user.id).present?
    if @card.present? && !(@product.seller_id == current_user.id)
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_info = customer.cards.data.first
    else
      flash.now[:alert] = 'カードを登録してください'
      redirect_to controller: "cards", action: "new"
    end
  end

  def ok
    @product = Product.where(buyer_id: current_user.id).order('updated_at DESC').first
    @prefecture = JpPrefecture::Prefecture.find current_user.sendaddress.prefectures
    # エラーハンドリング
    # プロダクトが存在しない、または現在の時刻と商品のアップ日時が5分離れている場合トップへリダイレクト
    if @product.blank? || (Time.zone.now - @product.updated_at) / 60 > 5
        flash.now[:alert] = '商品がありません'
        redirect_to root_path
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :category_id, :description, :brand, :size_id, :status_id, :shipfee_id, :shipregion_id, :estshipdate_id, images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_parents
    @parents = Category.roots.order(id: :ASC)
    @children = Category.find_all_by_generation(1)
  end

end