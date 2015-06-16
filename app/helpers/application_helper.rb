module ApplicationHelper

  def nav_link_to (click_text, action, url, style)
    if action_name == action
      return link_to click_text, url, :class => style
    else
      return link_to click_text, url
    end

  end


  def stars(num_of_stars)
    if (num_of_stars != nil && num_of_stars > 0 )
      return ((image_tag "movies/star.jpg", :size => "20x20") * num_of_stars).html_safe
    end

  end

  def is_admin?
    return current_user.try(:admin?)
  end


end
