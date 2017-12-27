class BoardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
      @boards=Board.all
  end

  def show
      @board=Board.find(params[:id])
  end

  def new
  end

  def create
    board=Board.create(title: params[:title], contents: params[:contents],user_id: current_user.id)
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
end
