module GoodsHelper
  def inv_number(good, found: nil)
    content_tag :button, title: "Informazioni originali in ugov", 
      class: "inv_number #{good.user_id ? 'with-owner' : 'without-owner'} #{'found' if found}",
                         data: { toggle: "popover", 
                                 html: "true",
                                 content: "#{h good.unibo_description}<br/><hr/>#{h good.build_year}<br/>&euro; #{h good.price}".html_safe } do
      "inv. #{good.inv_number.to_i}"
    end
  end

  def old_inv_number(good, found: nil)
    return "" unless good.old_inv_number 
    content_tag :span, class: "old_inv_number p-1 #{'found' if found}" do
      "#{good.old_inv_number.to_i} - #{good.old_org}"
    end
  end

  def link_to_unload(good)
    return "" unless user_admin? 
    icon = good.to_unload ? icon('times-circle') : icon('trash-alt', prefix: 'far')
    title = good.to_unload ? 'cancella lo scarico' : 'da scaricare'

    link_to icon, unload_good_path(good), remote: true, title: title
  end

  def div_good_id(good)
    "good_#{good.id}"
  end

  def confirmed_icon(t, size: 20)
    t ? "<i class='fas fa-exclamation-circle text-success' style='font-size: #{size}px' title='presenza del bene confermata'></i>".html_safe : ''
  end

  def description_for_owner(good)
    "#{good.name} #{good.description} (descrizione originale in u-gov: #{good.unibo_description})  "
  end
end
