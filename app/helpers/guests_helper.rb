module GuestsHelper
  def url_for_profile_pic(guest, size)
    if guest.photos.first.try(:image)
      guest.photos.first.image.url(:thumb)
    else
      url_for('/assets/placeholder_avatar_square.png')
    end
  end

  def stars(rating)
    return nil if rating.nil? || rating.blank?

    star  = case rating
            when 5
              "<i class='icon icon-star'></i>"
            else
              "<i class='icon icon-star-empty'></i>"
            end

    stars = ''
    rating.times do
      stars << star
    end

    raw(stars)
  end
end
