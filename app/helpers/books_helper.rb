module BooksHelper
  def strip_bold_tags(dirty_string)
    dirty_string.gsub("&lt;b&gt;", "").gsub("&lt;/b&gt;", "")
  end
end
