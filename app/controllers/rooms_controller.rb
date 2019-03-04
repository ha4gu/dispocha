class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.friendly.find(params[:id])
  end

  def new
    @room = Room.new
    # ルームID（.code）の初期値を自動生成する
    if @room.code.nil?
      until @room.has_valid_code?
        @room.code = Room.random_code
      end
    end
  end

  def create
    @room = Room.new(room_params)
    if @room.save # 保存に成功した場合
      flash[:success] = "ルームが作成されました。"
      redirect_to room_path(@room.code)
    else # 保存に失敗した場合
      flash.now[:danger] = "ルームの作成に失敗しました。"
      render :new
    end
  end

  def edit
    @room = Room.friendly.find(params[:id])
  end

  def update
    @room = Room.friendly.find(params[:id])
    if @room.update_attributes(room_params)
      flash[:success] = "ルームが更新されました。"
      redirect_to room_path(@room.code)
    else # 保存に失敗した場合
      flash.now[:danger] = "ルームの更新に失敗しました。"
      render :edit
    end
  end

  private

  def room_params
    params.require(:room).permit(:code, :name)
  end

end
