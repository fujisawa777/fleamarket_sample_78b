class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]

  def index
    @products = Product.includes(:images).order('created_at DESC')
  end

  def show
  end

  def new
    @product = Product.new
    @product.images.new
    @parents = Category.all.order("id ASC").limit(13)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :category_id, :description, :brand, :size_id, :status_id, :shipfee_id, :shipregion_id, :estshipdate_id, :seller_id, :buyer_id, images_attributes: [:src, :_destroy, :id]).merge(seller_id: 1)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end