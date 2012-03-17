# -*- encoding : utf-8 -*-
module ProfileHelper
  def require_fulfill_profile
    redirect_to new_user_session_path, :notice => "在继续之前，你需要登录。" and return if current_user.nil?
    redirect_to edit_profile_path, :notice => "在继续之前，你需要完善个人资料。" if current_user.profile.nil?
  end
end
