class ProfilesController < ApplicationController

  def create
    @profile = current_user.build_profile params[:profile]
    if @profile.save
      redirect_to edit_user_registration_path, :notice => t('profile.create_success')
    else
      render edit_user_registration_path
    end
  end

  def update
    @profile = current_user.profile
    if @profile.update_attributes params[:profile]
      redirect_to edit_user_registration_path, :notice => t('profile.update_success')
    else
      render edit_user_registration_path
    end
  end

  def show
    begin
      @profile = Profile.find params[:id]
    rescue ActiveRecord::RecordNotFound
      redirect_to '/', :alert => t('profile.not_found_or_not_auth')
    end
    authorize! :read, @profile
  end
end
