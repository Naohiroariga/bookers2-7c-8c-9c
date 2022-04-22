class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    to = Time.current.all_day
    from = (Time.current - 1.day).all_day
    @two = (Time.current - 2.day).all_day
    @three =  (Time.current - 3.day).all_day
    @four =   (Time.current - 4.day).all_day
    @five =   (Time.current - 5.day).all_day
    @six =   (Time.current - 6.day).all_day
    week = Time.current.all_week
    pre_week = (Time.current - 1.week).all_week

    @today_books = @books.books_count(to)
    @yesterday_books = @books.books_count(from)
    @week_books = @books.where(created_at: week)
    @pre_week_books = @books.where(created_at: pre_week)
    @the_day_before = (@today_books.count.to_f / @yesterday_books.count.to_f)*100
    @wow = (@week_books.count.to_f / @pre_week_books.count.to_f ) *100

  end

  def daily_posts
    
    user = User.find(params[:user_id])
    @books = user.books.where(created_at: params[:created_at].to_date.all_day)
    render :user_daily_posts_form
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
