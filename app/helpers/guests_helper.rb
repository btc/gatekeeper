module GuestsHelper
  def url_for_profile_pic(guest, size)
    if guest.photos.first.try(:image)
      guest.photos.first.image.url(:thumb)
    else
      url_for('/assets/placeholder_avatar_square.png')
    end
  end

end
