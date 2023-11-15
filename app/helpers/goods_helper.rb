module GoodsHelper

  def old_inv_number(good, found: nil)
    return "" unless good.old_inv_number 
    content_tag :span, class: "old_inv_number p-1 #{'found' if found}" do
      "#{good.old_inv_number.to_i} - #{good.old_org}"
    end
  end

  def link_to_unload(good)
    return "" unless helpers.policy(good).unload?

    icon = good.to_unload ? dm_icon("times-circle") : dm_icon("trash-alt")
    title = good.to_unload ? "cancella lo scarico" : "da scaricare"
    confirm = good.to_unload ? "Sicuri di volere cancella lo scarico?" : "Sicuri vi volere scaricare il materiale?"
    if good.to_unload
      button_to icon, unload_good_path(good), title: title, form: {data: {"turbo-confirm": confirm}, class: "d-inline px-0 mx-0"}
    else
      link_to icon, new_unload_good_path(good, modal: 1), title: title, data: {turbo_frame: :modal} 
    end
  end

  def status_icon(good, size: 20)
    if good.unconfirmed
      "<i class='fas fa-exclamation-triangle text-danger' style='font-size: #{size}px' title='presenza del bene non confermata'></i>".html_safe
    elsif good.confirmed
      "<i class='fas fa-check-circle text-success' style='font-size: #{size}px' title='presenza del bene confermata'></i>".html_safe
    else
      ""
    end
  end

  def description_for_owner(good)
    "#{good.name} #{good.description} (descrizione originale in u-gov: #{good.unibo_description})  "
  end
end
