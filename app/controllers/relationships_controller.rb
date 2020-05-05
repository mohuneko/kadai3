class RelationshipsController < ApplicationController
  def follow
  	current_user.follow(params[:id])
  	redirect_back(fallback_location: root_path)
  end

  def unfollow
  	current_user.unfollow(params[:id])
  	redirect_back(fallback_location: root_path)
  end

  def create
  @user = User.find(params[:relationship][:following_id])
  current_user.follow!(@user)
  redirect_to @user
 end

  # def create
  # 	Relationship.create(create_params)
  # 	redirect_to controller: 'users', action: 'index'
  # end

  def destroy
  	@user = Relationship.find(params[:id]).following
  	current_user.unfollow!(@user)
  	redirect_to @user
  end
   
  # def destroy
  # 	relationship = Relationship.find(params[:id])
  # 	relationship.destroy
  # 	redirect_to controller: 'users', action: 'index'
  # end

  def followers
    @user = User.find(params[:id])
    @users = @user.following_user
  end

  def followees
  	@user = User.find(params[:id])
  	@users = @user.follower_user

  end


  private
  def create_params
  	params.permit(:following_id).merge(follower_id: current_user.id)
  end
end


