module PostHelper
  def published_helper
    if published?
      return "Published"
    elsif draft?
      return "Draft"
    end
  end
end
