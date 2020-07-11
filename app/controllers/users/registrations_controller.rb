# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    # ユーザの箱を用意
    @user = User.new
  end

  # POST /resource
  def create
    # 実際のデータを作る
    @user = User.new(sign_up_params)
    # 実際のデータをバリデーションでみる
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    # session情報に保存する
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    # ユーザに紐づいた個人の箱を作る
    @personal = @user.build_personal
    render :new_personal
  end

  def create_personal
    @user = User.new(session["devise.regist_data"]["user"])
    @personal = Personal.new(personal_params)
    unless @personal.valid?
      flash.now[:alert] = @personal.errors.full_messages
      render :new_personal and return
    end
    session["devise.regist_data"][:personal] = @personal.attributes
    @sendaddress = @user.build_sendaddress
    render :new_sendaddress
  end
  
  def create_sendaddress
    @user = User.new(session["devise.regist_data"]["user"])
    @personal = Personal.new(session["devise.regist_data"]["personal"])
    @sendaddress = Sendaddress.new(sendaddress_params)
    unless @sendaddress.valid?
      flash.now[:alert] = @sendaddress.errors.full_messages
      render :new_sendaddress and return
    end
    session["devise.regist_data"][:sendaddress] = @sendaddress.attributes
    @user.build_personal(@personal.attributes)
    @user.build_sendaddress(@sendaddress.attributes)
    if @user.save
      session["devise.regist_data"].clear
      flash[:notice] = '内容が保存されました'
      sign_in(:user, @user)
    else
      flash.now[:alert]  = 'エラーがあります'
      render :new
    end
  end

  protected

  def personal_params
    params.require(:personal).permit(:birthday,:firstname,:lastname,:h_firstname,:h_lastname,:description,:image)
  end

  def sendaddress_params
    params.require(:sendaddress).permit(:s_firstname, :s_lastname, :s_h_firstname, :s_h_lastname, :zipcode, :prefectures, :municipalitities, :streetaddress,:room,:phonenumber)
  end

end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

