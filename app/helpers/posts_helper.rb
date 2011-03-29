module PostsHelper
  def title(page_title) 
    content_for(:title) {raw "<span id='title_text'>" + page_title + "</span>"}
  end

end
