class BoardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
      @boards=Board.all
  end

  def show
      @board = Board.find(params[:id])
      if user_signed_in?
      @like = Like.where(user_id: current_user.id, board_id: @board.id)#혹은 params[:id]
    else
      @like=[]
    end
    # @like=user_signed_in ? Like.where(user_id: current_user.id, board_id: @board.id): []
  end

  def new
  end

  def create
    board=Board.create(title: params[:title], contents: params[:contents],
                        user_id: current_user.id)
    redirect_to "/boards/#{board.id}"
  end

  def edit
    @board=Board.find(params[:id])
  end

  def update
    @board=Board.find(params[:id])
    @board.update(title: params[:title], contents: params[:contents])
    redirect_to "/boards/#{@board.id}"
  end

  def destroy
    @board=Board.find(params[:id])
    @board.destroy
    redirect_to "/"
  end

  def like_board
    user_like = Like.where(user_id: current_user.id, board_id: params[:id])
    if user_like.count>0
      #find랑 where차이는 find는 한개만 return. where는 배열로 여러개 리턴
      user_like[0].destroy
      #user_like.first.destroy
    else
      Like.create(user_id: current_user.id, board_id: params[:id])
    end
    @like=Board.find(params[:id]).likes.count #count는 메소드

  end

  def create_comment
    puts params[:contents]
    # 넘어오는 :contents는     $.ajax({
    #url: "/boards/<%=@board.id%>/create_comment", method: "POST", data: { contents: c}//inputname: value
        #});
    @comment=Comment.create(contents: params[:contents],user_id: current_user.id, board_id: params[:id])
  end

  def destroy_comment
  @comment = Comment.find(params[:comment_id]).destroy
    # puts "#{params[:comment_id]}번 delete"
  end
  
  def update_comment
    @comment=Comment.find(params[:comment_id])
    @comment.update(contents: params[:contents])
  end
end
