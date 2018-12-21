module GoodsHelper
  def original_info(good)
    content_tag :span, title: "Informazioni originali in ugov", 
      data: { toggle: "popover", 
              html: "true",
              content: "#{h good.unibo_description}<br/><hr/>#{h good.build_year}<br/>&euro; #{h good.price}".html_safe } do
      icon('info-circle')
    end
  end

  def link_to_unload(good)
    return "" unless current_user.is_admin? 
    icon = good.to_unload ? icon('times-circle') : icon('trash-alt', prefix: 'far')
    link_to icon, unload_good_path(good), remote: true
  end
end
