module CategoriesHelper
  def category_icon(c, size: 20)
    c or return "<i class='fas fa-question-circle' style='font-size: #{size}px'></i>".html_safe

    case c.code
    when 'pc'
      "<i class='fas fa-desktop' style='font-size: #{size}px'></i>".html_safe
    when 'notebook'
      "<i class='fas fa-laptop' style='font-size: #{size}px'></i>".html_safe
    when 'tablet'
      "<i class='fas fa-tablet-alt' style='font-size: #{size}px'></i>".html_safe
    when 'printer'
      "<i class='fas fa-print' style='font-size: #{size}px'></i>".html_safe
    when 'chair'
      "<i class='fas fa-chair' style='font-size: #{size}px'></i>".html_safe
    when 'hd'
      "<i class='far fa-hdd' style='font-size: #{size}px'></i>".html_safe
    when 'monitor'
      "<i class='fas fa-tv' style='font-size: #{size}px'></i>".html_safe
    when 'projector'
      "<i class='fas fa-video' style='font-size: #{size}px'></i>".html_safe
    when 'video'
      "<i class='fas fa-camera' style='font-size: #{size}px'></i>".html_safe
    when 'software'
      "<i class='fas fa-code' style='font-size: #{size}px'></i>".html_safe
    when 'server'
      "<i class='fas fa-server' style='font-size: #{size}px'></i>".html_safe
    when 'network'
      "<i class='fas fa-network-wired' style='font-size: #{size}px'></i>".html_safe
    when 'other'
      "<i class='fas fa-asterisk' style='font-size: #{size}px'></i>".html_safe
    else
      "<i class='fas fa-question-circle' style='font-size: #{size}px'></i>".html_safe
    end
  end

end
