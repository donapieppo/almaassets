module GoodsHelper
  def inv_number(good, found: nil)
    popover_content = "inv: #{good.inv_number}<br/>" +
                      "#{h good.unibo_description}<br/>" +
                      "sn: #{h good.sn}<br/><hr/>" +
                      "#{h good.build_year}<br/>&euro; #{h good.price}".html_safe
    content_tag :button, title: "Informazioni originali in ugov", 
                         class: "inv_number #{good.user_id ? 'with-owner' : 'without-owner'} #{'found' if found}",
                         data: { toggle: "popover", html: "true", content: popover_content } do
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
    return "" unless policy(good).unload?
    icon = good.to_unload ? dmicon('times-circle') : dmicon('trash-alt')
    title = good.to_unload ? 'cancella lo scarico' : 'da scaricare'

    link_to icon, unload_good_path(good), remote: true, title: title
  end

  def div_good_id(good)
    "good_#{good.id}"
  end

  def status_icon(good, size: 20)
    if good.unconfirmed
      "<i class='fas fa-exclamation-triangle text-danger' style='font-size: #{size}px' title='presenza del bene confermata'></i>".html_safe
    elsif good.confirmed
      "<i class='fas fa-exclamation-circle text-success' style='font-size: #{size}px' title='presenza del bene confermata'></i>".html_safe
    else
      ""
    end
  end

  def description_for_owner(good)
    "#{good.name} #{good.description} (descrizione originale in u-gov: #{good.unibo_description})  "
  end
end
