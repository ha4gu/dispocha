class RoomsController < ApplicationController
  before_action :must_be_logged_in, only: [:index, :edit, :update]
  before_action :must_be_admin, only: [:index]

  def index
    # index is only for admin account.
    @rooms = Room.all
  end

  def show
    @room = Room.friendly.find(params[:id])
    if @room.nil?
      # ルームが存在しない場合
      flash[:danger] = "アクセスできません。"
      redirect_to root_path
    else
      @qr = RQRCode::QRCode.new(room_url(@room), :size => 4, :level => :h)
      @posts = @room.posts.order(created_at: :desc)
      # ルームは存在している場合
      if account_signed_in?
        # ログイン済みの場合
        if current_account.is_accepted_in? @room
          # 当該ルームの入室権限を持つ場合
          @status = :accepted
          # => 投稿表示画面
        elsif current_account.has_persona_in? @room
          # 入室申請済みだが受諾されていない場合
          @status = :not_accepted
          # => 受諾待ち画面
        else # ログイン済みだがルームに紐づくペルソナが無い状態
          # 入室申請をまだ行っていない場合
          @status = :no_entry
          # => 参加申請画面
        end
      else
        # 未ログインの場合
        session[:room_visiting] = @room.code
        @status = :not_logged_in
        # => ログインを促す画面
      end
    end
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
    if @room.nil?
      flash[:danger] = "アクセスできません。"
      redirect_to root_path
    end
  end

  def update
    @room = Room.friendly.find(params[:id])
    if @room.nil?
      flash[:danger] = "アクセスできません。"
      redirect_to root_path
    else
      if @room.update_attributes(room_params)
        flash[:success] = "ルームが更新されました。"
        redirect_to room_path(@room.code)
      else # 保存に失敗した場合
        flash.now[:danger] = "ルームの更新に失敗しました。"
        render :edit
      end
    end
  end

  private

  def room_params
    params.require(:room).permit(:code, :name)
  end

end
