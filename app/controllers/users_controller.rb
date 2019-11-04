# frozen_string_literal: true

class UsersController < ApplicationController
  include ShopifyApp::Authenticated
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    # shouldn't show all users, just themselves so they can't edit other stores multipliers
    @users = Array.wrap(set_user)
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new do |u|
      u.email = user_session_email
      u.multiplier = user_params[:multiplier]
      u.email_verified = email_verified
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(multiplier: user_params[:multiplier])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def email_verified
    session[:shopify_user]['email_verified']
  end

  def user_session_email
    session[:shopify_user]['email']
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_email(session[:shopify_user]['email'])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:multiplier)
  end
end
