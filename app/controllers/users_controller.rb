require 'digest/bubblebabble'

class UsersController < ApplicationController
  load_and_authorize_resource :except => :update

  before_filter do
    params[:user] &&= user_params
  end

  before_action :set_user, only: [:show, :edit, :update, :destroy, :messages]

# poistettu coveragen lisäämiseks
  # GET /users
  # GET /users.json
 # def index
  #  @users = User.all
  #end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def messages

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    @user.channel = Digest::SHA256.bubblebabble (@user.username + @user.password_digest)

    @user.save
    @user.authenticate(params[:password])
    session[:user_id] = @user.id

    respond_to do |format|
      if @user.save
        notic = %Q[Tervetuloa! Nyt #{view_context.link_to("selaa työpaikkoja", open_jobs_path)} tai #{view_context.link_to("luo yritys ja sille avoimia työpaikkoja", new_company_path)}.]
        flash[:safe] = notic
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_companies
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Päivitetty' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :phonenumber, :email, :realname)
    end
end
