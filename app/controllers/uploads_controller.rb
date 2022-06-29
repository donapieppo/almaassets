require 'unibo_file_parser' 

class UploadsController < ApplicationController
  def new
    @upload = Upload.new(current_organization)
    authorize @upload
  end

  def create
    @upload = Upload.new(current_organization)
    authorize @upload
    @differences = {} 
    @new_goods   = [] 
    @subs        = {}
    excel_id_numbers = []

    begin
      parse_unibo_excel.each do |excel_unibo_good|
        inv_number = excel_unibo_good.get(:inv_number) or raise "No inv_number in #{excel_unibo_good.inspect}"
        
        if excel_unibo_good.get(:sub_inventory).to_i > 0
          @subs[inv_number] ||= []
          @subs[inv_number] << excel_unibo_good
          next
        end

        good = current_organization.goods.find_by_inv_number(inv_number) || current_organization.goods.new(inv_number: inv_number)

        desc      = excel_unibo_good.get(:description)
        unibouser = excel_unibo_good.get(:unibouser)
        notes     = excel_unibo_good.get(:notes)

        good.unibo_description = desc
        good.unibo_description = good.unibo_description + " [[#{unibouser}]]" unless unibouser.blank?
        good.unibo_description = good.unibo_description + " {{#{notes}}}"     unless notes.blank?

        good.build_year        = excel_unibo_good.get(:build_year) 
        good.old_org           = excel_unibo_good.get_cib_organization
        good.old_inv_number    = excel_unibo_good.get_cib_inv_number
        good.price             = excel_unibo_good.get(:price)
        good.sn                = excel_unibo_good.get(:sn)

        # attributes changable
        if good.new_record?
          good.description = desc
          @new_goods << good
        elsif good.changed_attributes.any?
          @differences[good] = good.changed_attributes 
        end
        
        # siamo alla fine sei sub (:sub_inventory == 0)
        if @subs[inv_number]
          @subs[inv_number].each do |sub|
            good.price = good.price.to_f + sub.get(:price).to_f
            good.unibo_description_sub = "#{good.unibo_description_sub} #{sub.get(:description)} (#{sub.get(:price)})"
          end
        end

        good.save!
        excel_id_numbers << good.id
      end
    rescue UniboFileMissingDissertationError => e
      redirect_to new_upload_path, alert: "Errore: #{e.to_s}" and return
    end
    ids_to_delete = (Good.select(:id).map(&:id).to_a - excel_id_numbers)
    Good.delete(ids_to_delete)
  end

  private

  def parse_unibo_excel
    if params[:ugov_excel]
      begin 
        return UniboFileParser.new(params[:ugov_excel].tempfile)
      rescue Ole::Storage::FormatError => e
        redirect_to(new_upload_path, alert: "Errore nel formato del file") and return 
      rescue UniboFileError => e
        redirect_to(new_upload_path, alert: e.to_s) and return
      rescue TypeError => e
        redirect_to(new_upload_path, alert: "Tipo di file excel errato. Provate ad aprire il file con il vostro excel e a salvarlo.") and return
      end
    else
      redirect_to(new_upload_path, alert: 'Selezionare il file.') and return 
    end
  end

  def add_value(excel_unibo_good)
    g = Good.find_by_inv_number(excel_unibo_good.get(:inv_number))
    g.update(price: g.price.to_f + excel_unibo_good.get(:price).to_f)
  end
end

#<UniboGood:0x00007fb4a9c863f0 @excel_line={"Inventario"=>"I0P4", "Descrizione Inventario"=>"DIPARTIMENTO DI MATEMATICA - inventario beni mobili", "Codice responsabile"=>nil, "Responsabile inventario"=>nil, "Numero inventario"=>"1", "Sub inventario"=>"0", "Num inventario Ateneo"=>"121832", "Numero buono"=>"316", "Tipo buono"=>"Carico", "Codice Tipo Carico/Scarico"=>"C01", "Descrizione Tipo Carico/Scarico"=>"ACQUISTO", "Data carico"=>"01/01/2015", "Tipo Campo Attivita"=>"Istituzionale", "Descrizione bene"=>"NOTEBOOK MODELLO: SERIE 3; PROCESSORE: CORE i5, 4 GBRAM, SISTEMA OPERATIVO: MICROSOFT WINDOWS 7,HOME PREMIUM, BIT S.O.:64 - S/N: HWUJ91GC900305V, DIM: 31 x 21,5 x 0,05 cm , COLORE GRIGIO METALLIZZATO, UBICAZIONE FAC.ECONOMIA SEDE DI RIMINI - PROF.ANGELINI NATASCIA", "Valore convenzionale"=>988.99, "Esercizio bene migrato"=>"2012", "Numero carico bene migrato"=>"2012/I0P4/C/1/1/1/0", "Data carico migrato"=>"28/04/2016", "Codice Categoria"=>"C.02.02.17", "Descrizione Categoria"=>"ELABORATORI PORTATILI", "Codice Immobilizzazione"=>"110I", "Descrizione Immobilizzazione"=>"ATTREZZATURE INFORMATICHE", "Codice Spazio"=>"I0P4...", "Descrizione Spazio"=>"DIPARTIMENTO DI MATEMATICA", "Locale"=>nil, "Codice resp. spazio"=>nil, "Responsabile Spazio"=>nil, "Codice Possessore"=>nil, "Possessore"=>nil, "Codice Fornitore"=>"1951848", "Denominazione Fornitore"=>"FERRARI COMPUTER BOLOGNA S.R.L.", "Anno di Fabbricazione"=>"2012", "Numero seriale"=>nil, "CIB"=>nil, "Marca"=>nil, "Numero targa"=>nil, "Condizione Bene"=>nil, "Garanzia Da"=>nil, "Garanzia A"=>nil, "Uo di riferimento"=>"000963", "Note"=>"2012 I00013A0P4 UBICAZIONE FAC.ECONOMIA SEDE DI RIMINI - PROF.ANGELINI NATASCIA", "Nome Tipo DG"=>nil, "Data Dg"=>nil, "Numero DG"=>nil, "Data Registrazione DG"=>nil, "Numero registrazione DG"=>nil, "Edificio Collegato (Spazio)"=>nil, "Aliquota Ammortamento Ordinario"=>"33,33%", "Aliquota Ammortamento Fiscale"=>nil, "Dg Contributo Impianto"=>nil, "Percentuale Contributo Impianto"=>nil}>
