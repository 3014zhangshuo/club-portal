class ProfilesController < ApplicationController

  def create
    @university_id = (params[:profile]).delete :university_id
    @profile = current_user.build_profile params[:profile]
    @profile.university_id = @university_id

    if University.exists? @university_id and @profile.save
      redirect_to edit_user_registration_path, :notice => t('profile.create_success')
    else
      render :action => 'edit', :alert => t('profile.error')
    end
  end

  def update
    @profile = current_user.profile

    @university_id = (params[:profile]).delete :university_id

    if University.exists? @university_id
      @profile.update_attribute :university_id, @university_id
    end

    if @profile.update_attributes params[:profile]
      redirect_to edit_user_registration_path, :notice => t('profile.update_success')
    else
      render :action => 'edit', :alert => t('profile.error')
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
