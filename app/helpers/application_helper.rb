module ApplicationHelper
  def safe_image_tag(source, size, options = {})
    if source != nil and source != "" then
    	image_tag(source, options)
    elsif size == "small" then
      image_tag("no-photo.gif", options)
    elsif sisze == "large" then
      image_tag("no-book-cover.png", options)
    end
  end 
end
