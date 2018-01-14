class CommentsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "comment was successfully created"
      redirect_to restaurant_path(@restaurant)
    else
      flash[:alert] = "comment cannot be blank"
      redirect_to restaurant_path(@restaurant, comment_params)
    end

  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    #@comment = @restaurant.comments.find(params[:id])
    @comment = Comment.find(params[:id])
    if current_user.admin?
      @comment.destroy
      flash[:alter] = "留言已刪除"
      redirect_to restaurant_path(@restaurant)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
