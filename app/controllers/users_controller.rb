class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    to = Time.current.all_day
    from = (Time.current - 1.day).all_day
    week = Time.current.all_week
    pre_week = (Time.current - 1.week).all_week

    @today_count = @books.where(created_at: to).count
    @yesterday_count = @books.where(created_at: from).count
    @week_count = @books.where(created_at: week).count
    @pre_week_count = @books.where(created_at: pre_week).count
    @the_day_before = (@today_count.to_i / @yesterday_count.to_i)*100
    @wow = (@week_count.to_i / @pre_week_count.to_i ) *100



  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
