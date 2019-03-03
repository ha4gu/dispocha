module ApplicationHelper
  def build_title(page_title = '')
    base_title = "dispocha"
    if page_title.empty?
      base_title
    else
      page_title + " - " + base_title
    end
  end
end
