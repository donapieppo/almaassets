ORG_ID = 1

require 'unibo_file_parser' 

namespace :almaassets do

  desc "show headers from excel UGOV file" 
  task show_excel_headers: :environment do
    excel = UniboFileParser.new(ARGV[1])
    excel.get(1).keys.each do |k|
      puts "#{k.ljust(40, '.')} #{UniboExcelMappings.unibo_to_sym_attr(k)}"
    end
  end

  desc "test excel file (show original goods)" 
  task test_file: :environment do
    excel = UniboFileParser.new(ARGV[1])
    excel.each_original do |line|
      system "clear"
      line.each do |k, v|
        puts "#{k.ljust(40, '.')} #{v}"
      end
      puts "\n\n press enter or ctrl+c"
      res = STDIN.gets 
    end
  end

  desc "parsa unibouser"
  task parse_unibouser: :environment do
    excel = UniboFileParser.new(ARGV[1])
    excel.each do |unibo_good|
      unibouser = unibo_good.get(:unibouser) or next
      surname, name = unibouser.split(/ /)

      u = user.where(name: name).where(surname: surname).first

      g = good.find_by_inv_number(unibo_good.get(:inv_number))
      if u 
        g.update_attribute(:user_id, u.id) 
      else
        p unibouser
        p g.description
      end
    end
  end

  desc "parsa category"
  task parse_category: :environment do
    excel = UniboFileParser.new(ARGV[1])
    excel.each do |unibo_good|
      c_code  = unibo_good.get_category or next
      if category = Category.find_by_code(c_code)
        Good.find_by_inv_number(unibo_good.get(:inv_number)).update_attribute(:category_id, category.id)
      end
    end
  end

  desc "insert / updates assets from UGOV excel file"
  task insert_or_update_assets: :environment do
    excel = UniboFileParser.new(ARGV[1])

    excel.each do |unibo_good|
      inv_number = unibo_good.get(:inv_number) or raise "No inv_number in #{unibo_good.inspect}"

      good = Good.find_by_inv_number(inv_number) || Good.new(inv_number: inv_number)

      desc      = unibo_good.get(:description)
      unibouser = unibo_good.get(:unibouser)
      notes     = unibo_good.get(:notes)

      # to keep and not change by rails (just update if they change in ugov)
      # add or update always

      # Unibo description is completed as string by user (string) and notes
      good.unibo_description = desc
      good.unibo_description = good.unibo_description + " [[#{unibouser}]]" unless unibouser.blank?
      good.unibo_description = good.unibo_description + " {{#{notes}}}"     unless notes.blank?

      good.build_year        = unibo_good.get(:build_year) 
      good.old_org           = unibo_good.get_cib_organization
      good.old_inv_number    = unibo_good.get_cib_inv_number
      good.price             = unibo_good.get(:price)

      # attributes for rails (changable)
      if good.new_record?
        good.name        = unibo_good.get(:name)
        good.description = desc
      end

      puts "to save #{inv_number}"
      good.save!
    end
  end
end

