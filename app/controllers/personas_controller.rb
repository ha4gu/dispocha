class PersonasController < ApplicationController
  before_action :must_be_logged_in
  before_action :set_common_instance_variables

  def new
    if Persona.find_by(account_id: current_account.id, room_id: @room.id)
      # 既にPersonaを持っている場合、新規申請は不可のためリダイレクト
      flash[:warning] = "入室申請は既に完了しています。"
      redirect_to room_path(@room)
    else
      # まだこのルームのPersonaを持っていない場合、新規申請フォームを表示
      @persona = Persona.new
    end
  end

  def create
    @persona = Persona.new(persona_params)
    if @persona.account_id != current_account.id || @persona.room_id != @room.id
      # フォームデータ改ざん
      flash.now[:danger] = "不正な操作が検出されました"
      redirect_to root_path
      # ToDo: 記録を残したい
    elsif @persona.save # 改ざんが無く、保存に成功した場合
      flash[:success] = "申請が完了しました。受諾されるまでお待ちください。"
      redirect_to room_path(@room)
    else # 保存に失敗した場合
      flash.now[:danger] = "申請できません。"
      render :new
      # ToDo: 記録を残したい
    end
  end

  def edit
    @persona = Persona.find_by(account_id: current_account.id, room_id: @room.id)
    if @persona.nil?
      # まだこのルームのPersonaを持っていない場合、編集は不可のためリダイレクト
      flash[:warning] = "編集はできません。"
      redirect_to room_path(@room)
    end
  end

  def update
    @persona = Persona.find_by(account_id: current_account.id, room_id: @room.id)
    if @persona.nil?
      flash[:danger] = "アクセスできません。"
      redirect_to root_path
    else
      if @persona.account_id != current_account.id || @persona.room_id != @room.id
        # フォームデータ改ざん
        flash.now[:danger] = "不正な操作が検出されました"
        redirect_to root_path
        # ToDo: 記録を残したい
      elsif @persona.update_attributes(persona_params) # 改ざんが無く、保存に成功した場合
        flash[:success] = "設定が更新されました。"
        redirect_to room_path(@room)
      else # 保存に失敗した場合
        flash.now[:danger] = "設定の更新に失敗しました。"
        render :new
        # ToDo: 記録を残したい
      end
    end
  end

  def destroy
    @persona = Persona.find_by(account_id: current_account.id, room_id: @room.id)
    if @persona.nil?
      flash[:danger] = "アクセスできません。"
      redirect_to root_path
    else
      @persona.destroy
      redirect_to room_path(@room)
    end
  end

  private

  def set_common_instance_variables
    @room = Room.friendly.find(params[:id])
  end

  def persona_params
    params.require(:persona).permit(:account_id, :room_id, :name, :icon)
  end
end
