module SearchesHelper

  
  def search_titlify(title)
    raw "<div id='search_title'>" + title + "</div>"
  end
  def no_tag_text
    raw "None Defined:(. Click to Edit"
  end
end
