class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def index
    @groups = Group.all
    @book = Book.new
    @user = User.find(params[:id])

  end

  def edit
    @group = Group.find(params[:id])
    if @group.owner_id == current_user.id
      render :edit
    else
      redirect_to groups_path
    end
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render :nwe
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "You have updated group successfully"
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end
end
