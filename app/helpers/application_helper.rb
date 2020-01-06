module ApplicationHelper
  def full_title page_title = ""
    if page_title.empty?
      (t ".title_header").to_s
    else
      page_title + " | " + (t ".title_header").to_s
    end
  end
end
