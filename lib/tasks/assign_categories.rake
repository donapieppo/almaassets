namespace :almaassets do

  desc "inserisce le categorie"
  task assign_categories: :environment do
    chair_id = Category.find_by_code('chair').id
    video_id = Category.find_by_code('video').id
    server_id = Category.find_by_code('server').id

    Good.where(category_id: nil).find_each do |good|
      if good.unibo_description =~ /SEDIA (FISSA|PIEGHEVOLE|GIREVOLE)/i 
        good.update_attribute(:category_id, chair_id)
      elsif good.unibo_description =~ /(PROIETTORE|VIDEOPROIETTORE|VIDEO PROIETTORE)/i 
        good.update_attribute(:category_id, video_id)
      elsif good.unibo_description =~ /SERVER)/i 
        good.update_attribute(:category_id, server_id)
      end
    end

  end
end

