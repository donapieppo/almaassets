module GoodsHelper
  def original_info(good)
    content_tag :span, title: "Informazioni originali in ugov", 
      data: { toggle: "popover", 
              html: "true",
              content: "#{h good.unibo_description}<br/><hr/>#{h good.build_year}<br/>&euro; #{h good.price}".html_safe } do
      icon('info-circle')
    end
  end
end
