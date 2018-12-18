require 'unibo_file_parser' 

namespace :almaassets do

  desc "inserisce gli utenti"
  task assign_users: :environment do
    pietro = User.find_by_upn('pietro.donatini@unibo.it')
    p pietro

    Good.where(user_id: nil).find_each do |good|
      if good.description =~ /laboratorio piano terra/i or 
         good.description =~ /lab\.?\s*didattica/i or 
         good.description =~ /lab\.?\s*studenti/i or 
         good.description =~ /laboratorio studenti/i or 
         good.description =~ /aula /i or 
         good.description =~ /lab(oratorio)?\.? (docenti|assegnisti)/i or
         good.description =~ /switch hp/i or
         good.description =~ /multimediale.*terra/i or
         good.description =~ /ufficio tecnici/i or
         good.description =~ /uff\.?\s*tecnici/i or
         good.description =~ /sala server/i or
         good.description =~ /scantinato server/i 
        p good.description
        good.update_attribute(:user_id, pietro.id)
      end
    end

    # nome E cognome
    User.find_each do |u|
      x = "#{u.name} #{u.surname}"
      y = "#{u.surname} #{u.name}"
      Good.where(user_id: nil).find_each do |good|
        if good.description =~ /#{x}/i or good.description =~ /#{y}/i 
          puts "----"
          puts good.description.downcase
          puts u
          good.update_attribute(:user_id, u.id)
        end
      end
    end

    # solo cognome con prof.
    User.find_each do |u|
      Good.where(user_id: nil).find_each do |good|
        if good.description =~ /(prof|dott)(\.ssa)?\.?\s*#{u.surname}/i or
           good.description =~ /(prof|dott)(\.ssa)?\.?\s*#{u.name[0]}\.\s?#{u.surname}/i
          puts "----"
          puts good.description.downcase
          puts u
          good.update_attribute(:user_id, u.id)
        end
      end
    end

  end
end

