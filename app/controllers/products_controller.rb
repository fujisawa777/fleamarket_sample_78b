class ProductsController < ApplicationController


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
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def product_params
    params.require(:product).permit(:name, :price, :category_id, :discription, :brand, :size_id, :status_id, :shipfee_id, :shipregion_id, :estshipdate_id, :seller_id, :buyer_id, images_attributes: [:src])
  end
    

end