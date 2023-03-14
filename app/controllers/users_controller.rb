class UsersController < ApplicationController
  require 'net/http'
  
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @stub = Stub.new
    @stubs = @user.stubs
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.find_or_create_by(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update

    respond_to do |format|
      if is_valid?(user_params[:start_url]) && @user.stubs.create(start_url: user_params[:start_url], end_url: (0...4).map { (65 + rand(26)).chr }.join) 

      # The above randomization would be relplaced by plucking a value from an array persisting in memory on on a cache server
      # representing a defined set of elgible paths that are randomized and sorted by character length.  At this point,
      # a delayed job would be intiated if the length of the remaining array warrants the execution of a task adding new
      # entries to the array representing a new set paths with an additional character.  Doing so would ensure optimal URL brevity,
      # operational performance and avoid viod collisions.

        format.html { redirect_to user_url(@user), notice: "New Shortened URL was successfully created." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to user_url(@user), notice: "Your Shortened URL could not be created." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :start_url)
    end

    def is_valid?(url)
      puts url
      begin
        Net::HTTP.get_response(URI(url)).code == "200"
      rescue
        false
      end
    end
end
