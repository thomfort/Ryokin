module AdvisorsHelper
  
  def show_stars(nb)
    nb.times do
      image_tag "star.png"
    end
  end
  
end
