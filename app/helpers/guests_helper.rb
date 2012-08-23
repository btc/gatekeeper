module GuestsHelper
  def url_for_profile_pic(guest, size)
    if guest.photos.first.try(:image)
      guest.photos.first.image.url(:thumb)
    else
      url_for('/assets/placeholder_avatar_square.png')
    end
  end

  def stars(rating)
    return nil if rating.blank?

    star = "<i class='icon icon-star'></i>"
    stars = ''
    rating.times do
      stars << star
    end

    raw(stars)
  end
end
