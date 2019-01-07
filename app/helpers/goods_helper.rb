module GoodsHelper
  def inv_number(good)
    content_tag :button, title: "Informazioni originali in ugov", 
                         class: "inv_number #{good.user_id ? 'with-owner' : 'without-owner'}",
                         data: { toggle: "popover", 
                                 html: "true",
                                 content: "#{h good.unibo_description}<br/><hr/>#{h good.build_year}<br/>&euro; #{h good.price}".html_safe } do
      "inv. #{good.inv_number}"
    end
  end

  def link_to_unload(good)
    return "" unless current_user.is_admin? 
    icon = good.to_unload ? icon('times-circle') : icon('trash-alt', prefix: 'far')
    title = good.to_unload ? 'cancella lo scarico' : 'da scaricare'

    link_to icon, unload_good_path(good), remote: true, title: title
  end

  def old_inv_number(good)
    return "" unless good.old_inv_number 
    content_tag :span, class: "badge badge-secondary p-1" do
      good.old_inv_number.to_s + " - " + good.old_org.to_s
    end
  end

  def div_good_id(good)
    "good_#{good.id}"
  end
end
