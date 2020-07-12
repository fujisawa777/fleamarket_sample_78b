class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]
  before_action :set_parents, only:[:new, :edit,:create , :update]

  def index
    @products = Product.includes(:images).order('created_at DESC')
  end

  def show
  end

  def new
    @product = Product.new
    @product.images.new
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
  end

  def update
    if @product.update(product_params)
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
        @product = Product.includes(:images).order('created_at DESC')
        flash.now[:alert]  = '商品が削除されませんでした'
        render :index
      end
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :category_id, :description, :brand, :size_id, :status_id, :shipfee_id, :shipregion_id, :estshipdate_id, :seller_id, :buyer_id, images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_parents
    @parents = Category.where(parent_id: nil).order(id: :ASC)
  end
end