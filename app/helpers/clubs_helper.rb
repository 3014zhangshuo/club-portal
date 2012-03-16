module ClubsHelper
  def find_by_permalink
    @club = Club.fetch params[:id]
  end

  def find_member profile, club_id
    Membership.where(:profile_id => profile.id, :club_id => club_id).first
  end

end
