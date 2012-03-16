class ClubsController < ApplicationController
  include ClubsHelper

  before_filter :find_by_permalink, :except => [:new, :index, :create]
  load_and_authorize_resource

  def create
    begin
      Club.transaction do
        @club = Club.new :name => params[:club][:name],
                         :permalink => params[:club][:permalink],
                         :intro => params[:club][:intro]
        @club.university = current_user.profile.university
        if ClubType.exists? params[:club][:club_type_id]
          @club.club_type_id = params[:club][:club_type_id]
        else
          @club.club_type_id = 1
        end
        @founder = @club.memberships.new
        @founder.profile = current_user.profile
        @founder.state = 'audited'
        @founder.role = 'admin'

        if @club.save
          redirect_to '/', :notice => t('club.create_success')
        else
          render :action => 'new'
        end
      end
    rescue Exception => ex
      render :action => 'new', :notice => t('club.create_error')
    end
  end

  def update
    params[:club].delete :university_id
    params[:club].delete :club_type_id

    @club = Club.find params[:id]
    if @club.update_attributes params[:club]
      redirect_to edit_club_path, :notice => t('club.update_success')
    else
      render :action => 'edit', :notice => t('club.update_error')
    end
  end

  def new
    @club = Club.new
  end

  def show

  end

  def edit

  end

  def index
    if current_user.nil? or current_user.profile.nil?
      @clubs = Club.audited
    else
      if params.has_key?:my
        @clubs = current_user.profile.clubs.audited
      elsif params.has_key?:my_university
        @clubs = Club.where(:university_id => current_user.profile.university.id).audited
      else
        @clubs = Club.audited
      end
    end
  end

  def homepage

  end

  def dashboard

  end

  private

end
