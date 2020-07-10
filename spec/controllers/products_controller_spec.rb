require 'rails_helper'

describe ProductsController do
  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it "assigns the requested product to @product" do
      product = create(:product)
      post :create, params: { id: product }
      expect(assigns(:product)).to eq product
    end

    it "renders the :create template" do
      product = create(:product)
      post :create, params: { id: product }
      expect(response).to render_template :product
    end
  end

  describe 'GET #index' do
    it "populates an array of products ordered by created_at DESC" do
      products = create_list(:product, 3) 
      get :index
      expect(assigns(:products)).to match(products)
    end

    it "renders the :index template" do
    end
  end

end