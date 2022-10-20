class GroupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @groups = Group.where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @group = Group.new
    @icons = Group.icon_list
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path, notice: 'Category was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.expenses.each(&:destroy)
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'Category was successfully destroyed.' }
    end
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end

  private :group_params
end
