module ObservationsHelper

  def obs_img_for(observation)
    if observation.photos.nil?
      url = "http://placehold.it/185x185"
    else
      url = observation.photos[0].small_url
    end
    image_tag(url, alt: observation.species_guess, class: "img-responsive inner_img")
  end
end