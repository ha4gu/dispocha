class ApplicationController < ActionController::Base

  private

  def must_be_logged_in
    unless account_signed_in?
      flash[:danger] = "ログインしてください。"
      redirect_to new_account_session_path
    end
  end

  def must_be_admin
    unless current_account.admin?
      flash[:danger] = "アクセスできません。"
      redirect_to root_path
    end
  end
end
