module ApplicationHelper
  def safe_image_tag(source, options = {})
    if source != nil and source != "" then
    	image_tag(source, options)
    end
  end 
end
