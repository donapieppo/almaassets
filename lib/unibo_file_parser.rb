require 'roo' 
require 'roo-xls'

class UniboFileError < RuntimeError; end
class UniboFileMissingDissertationError < RuntimeError; end

# with unibo file names
class UniboGood
  def initialize(excel_line)
    @excel_line = excel_line
  end

  def get(attr)
    @excel_line[UniboExcelMappings.sym_to_unibo_attr(attr)]
  end

  def get_cib_organization
    UniboExcelMappings.old_organization((get(:cib) || "").split('/')[1])
  end

  def get_cib_inv_number
    (get(:cib) || "").split('/')[0]
  end

  def get_cathegory
    UniboExcelMappings.tipologia(get(:cathegory_unibo_description))
  end
end

# pass an excel file from unibo 
# excel = UniboFileParser.new('/tmp/pippo')
class UniboFileParser
  def initialize(file)
    excel = Roo::Excel.new(file) 
    # facciamo leggere con gli headers e poi li buttiamo
    @file_content = excel.parse(headers: true, clean: true).drop(1)
  end

  def each
    @file_content.each do |excel_line|
      yield UniboGood.new(excel_line)
    end
  end

  private 

end

