require 'unibo_file_parser' 

namespace :almaassets do

  desc "test excel file" 
  task test_file: :environment do
    excel = UniboFileParser.new(ARGV[1])
    excel.each do |unibo_good|
      unibouser = unibo_good.get(:unibouser)
      next if unibouser.blank?
      # puts unibo_good.get(:inv_number) + " - " + (unibo_good.get(:cib) || "-") + " - " + unibo_good.get(:description) + " - " + (unibo_good.get(:brand) || "?")
      puts unibo_good.get(:inv_number) + " - " + (unibo_good.get(:cib) || "-") + " - " + unibo_good.get(:description) + " - " + unibouser
    end
  end

  desc "parsa cib"
  task parse_cib: :environment do
    excel = UniboFileParser.new(ARGV[1])
    excel.each do |unibo_good|
      p unibo_good.get_cib_organization
      p unibo_good.get_cib_inv_number
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

  desc "inserisce gli assets"
  task insert_assets: :environment do
    excel = UniboFileParser.new(ARGV[1])

    excel.each do |unibo_good|
      old = Good.find_by_inv_number(unibo_good.get(:inv_number))
      unless old
        desc = unibo_good.get(:description)
        u    = unibo_good.get(:unibouser)
        n    = unibo_good.get(:notes)

        # to keep and not change
        unibo_desc = desc
        unibo_desc = unibo_desc + " [[#{u}]]" unless u.blank?
        unibo_desc = unibo_desc + " {{#{n}}}" unless n.blank?

        g = Good.create!(inv_number:     unibo_good.get(:inv_number),
                         name:           unibo_good.get(:name),
                         description:    desc,
                         unibo_description: unibo_desc,
                         build_year:     unibo_good.get(:build_year), 
                         price:          unibo_good.get(:price),
                         old_org:        unibo_good.get_cib_organization,
                         old_inv_number: unibo_good.get_cib_inv_number)
      end
    end
  end
end

