module ApplicationHelper

  def full_title(page_title='')
    base_title = "TODO LIST"
    if page_title.empty?
      base_title
    else
      page_title + "|" + base_title
    end
  end

  def fa_icon(names, options = {})
    names = (names.is_a?(Array) ? names : names.split(/\s+/)).map { |n| "fa-#{n}" }
    classes = %W(fa #{names.join(' ')} #{options.delete(:class)})
    icon = content_tag(:i, nil, options.merge(class: classes))
    (block_given? ? yield(icon) : icon).html_safe
  end
end
