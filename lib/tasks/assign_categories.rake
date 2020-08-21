namespace :almaassets do

  desc "inserisce le categorie"
  task assign_categories: :environment do
    chair_id    = Category.find_by_code('chair').id
    video_id    = Category.find_by_code('video').id
    server_id   = Category.find_by_code('server').id
    printer_id  = Category.find_by_code('printer').id
    pc_id       = Category.find_by_code('pc').id
    monitor_id  = Category.find_by_code('monitor').id
    notebook_id = Category.find_by_code('notebook').id
    network_id  = Category.find_by_code('network').id
    tablet_id   = Category.find_by_code('tablet').id

    Good.where(category_id: nil).find_each do |good|
      if good.unibo_description =~ /SEDIA (FISSA|PIEGHEVOLE|GIREVOLE|OPERATIVA|SETPOINT|CON SEDUTA|ERGONOMICA)/i 
        good.update_attribute(:category_id, chair_id)
      elsif good.unibo_description =~ /SCRIVANI|ARMADIO|CASSETTIER|ANTA|APPENDIABITI|ARMADIATURE|ARMADIETTO|CATTEDRA|LAMPADA|LAVAGNA|LIBRERIA|POLTRONCIN|POLTRONA|SEGGIOLA|TAVOLINO|TAVOLO|PANCA IN LEGNO|SEDIA|TENDA|VENTILATORE|ATTACCAPANNI|SGABELLO|APPENDIABITO|CONDIZIONATORE/i
        good.update_attribute(:category_id, chair_id)
      elsif good.unibo_description =~ /PROIETTORE|VIDEOPROIETTOR|VIDEO PROIETTOR|Videoregistrator|Videocamer/i 
        good.update_attribute(:category_id, video_id)
      elsif good.unibo_description =~ /SERVER|GRUPPO DI CONTINUIT/i 
        good.update_attribute(:category_id, server_id)
      elsif good.unibo_description =~ /STAMPANTE|LASERJET|MULTIFUNZIONE/i 
        good.update_attribute(:category_id, printer_id)
      elsif good.unibo_description =~ /PC DELL|WORKSTATION|PC\s+DESKTOP|PC OLIDATA|PERSONAL COMPUTER|PC OPTIPLEX|PC ASSEMBLATO|PC MAXDATA|COMPUTER ASSEMBLATO|ELAB. IMAC 2|IMAC 2|Precision 36/i 
        good.update_attribute(:category_id, pc_id)
      elsif good.unibo_description =~ /MONITOR/i 
        good.update_attribute(:category_id, monitor_id)
      elsif good.unibo_description =~ /Tend(a|e) (motorizzate|Veneziana)/i 
        good.update_attribute(:category_id, chair_id)
      elsif good.unibo_description =~ /PC\s+PORTATILE|NOTEBOOK|MACBOOK AIR|PC SLIM CASE|MACBOOK 12|Surface Pro|ELITEBOOK/i 
        good.update_attribute(:category_id, notebook_id)
      elsif good.unibo_description =~ /PROCURVE|SWITCH|WIRELESS ROUTER|WIRELESS ACCESS POINT/i 
        good.update_attribute(:category_id, network_id)
      elsif good.unibo_description =~ /IPAD|GALAXY TAB/i 
        good.update_attribute(:category_id, tablet_id)
      elsif good.unibo_description =~ /MACBOOK/i 
        good.update_attribute(:category_id, notebook_id)
      else
        puts "Non trovato #{good.unibo_description}"
      end
    end

  end
end

