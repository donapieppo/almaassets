class UniboExcelMappings
  @@unibo_to_sym_mappings = {
    "Numero inventario"=>:inv_number,
    "Num inventario Ateneo"=>:unibo_number,
    "Numero buono"=>:load_number,
    "Data carico"=>:load_date,
    "Descrizione bene"=>:description,
    "Valore convenzionale"=>:price,
    "Esercizio bene migrato"=>:migration_year,
    "Data carico migrato"=>nil,
    "Codice Categoria"=>:cathegory_unibo_code,
    "Descrizione Categoria"=>:cathegory_unibo_description,
    "Codice Possessore"=>:unibouser_code,
    "Possessore"=>:unibouser,
    "Anno di Fabbricazione"=>:build_year,
    "Numero seriale"=>:sn,
    "CIB"=>:cib, # !!!!!
    "Marca"=>:brand,
    # "Numero targa"=>nil
    # "Condizione Bene"=>nil
    # "Garanzia Da"=>nil
    # "Garanzia A"=>nil
    # "Uo di riferimento"=>"000963"
    # "Note"=>nil
    # "Nome Tipo DG"=>"Fattura Acquisto"
    # "Data Dg"=>"25/10/2018"
    # "Numero DG"=>"257PA"
    # "Data Registrazione DG"=>"31/10/2018"
    # "Numero registrazione DG"=>"99"
    # "Edificio Collegato (Spazio)"=>nil
    # "Codice Fornitore"=>:supplier_code,
    # "Denominazione Fornitore"=>:supplier_name,
  }
  @@sym_to_unibo_mappings = @@unibo_to_sym_mappings.invert

  @@forced_mappings = { 
    "Inventario"=>"I0P4",
    "Descrizione Inventario"=>"DIPARTIMENTO DI MATEMATICA - inventario beni mobili",
    "Sub inventario"=>"0",
    "Numero carico bene migrato"=>nil,
    "Codice Immobilizzazione"=>"1040",
    "Descrizione Immobilizzazione"=>"CONCESSIONI E LICENZE",
    "Codice Spazio"=>"I0P4...",
    "Descrizione Spazio"=>"DIPARTIMENTO DI MATEMATICA",
    "Locale"=>nil,
    "Codice resp. spazio"=>nil,
    "Responsabile Spazio"=>nil
  }

  def self.sym_to_unibo_attr(s)
    @@sym_to_unibo_mappings[s]
  end

  @@old_organizations = {
    "EX85"     => 'matpre2013',
    "EXE3_DIP" => 'matemates', 
    "EXE3_MAN" => nil, 
    "EX_I055"  => 'ciram', 
    "I040"     => nil # 4 cose
  }

  def self.old_organization(s)
    @@old_organizations[s]
  end
end

#  "Inventario"=>"I0P4"
#  "Descrizione Inventario"=>"DIPARTIMENTO DI MATEMATICA - inventario beni mobili"
#  "Numero inventario"=>"2254"
#  "Sub inventario"=>"0"
#  "Num inventario Ateneo"=>"313615"
#  "Numero buono"=>"27"
#  "Data carico"=>"13/11/2018"
#  "Descrizione bene"=>"Mathematica - Manutenzione Premier Service 12 mesi per licenza di rete con 2 accessi concorrenti Solo licenza via email - PS rinnovo 12 mesi 2 Network PERIODO 16/11/2018- 16/11/2019"
#  "Valore convenzionale"=>1502.13
#  "Esercizio bene migrato"=>nil
#  "Numero carico bene migrato"=>nil
#  "Data carico migrato"=>nil
#  "Codice Categoria"=>"C.01.03.03"
#  "Descrizione Categoria"=>"LICENZE D'USO SOFTWARE"
#  "Codice Immobilizzazione"=>"1040"
#  "Descrizione Immobilizzazione"=>"CONCESSIONI E LICENZE"
#  "Codice Spazio"=>"I0P4..."
#  "Descrizione Spazio"=>"DIPARTIMENTO DI MATEMATICA"
#  "Locale"=>nil
#  "Codice resp. spazio"=>nil
#  "Responsabile Spazio"=>nil
#  "Codice Possessore"=>nil
#  "Possessore"=>nil
#  "Codice Fornitore"=>"1950273"
#  "Denominazione Fornitore"=>"ADALTA s.n.c. di Fazzi Marco e Marcantoni Giampaolo"
#  "Anno di Fabbricazione"=>"2018"
#  "Numero seriale"=>nil
#  "CIB"=>nil
#  "Marca"=>nil
#  "Numero targa"=>nil
#  "Condizione Bene"=>nil
#  "Garanzia Da"=>nil
#  "Garanzia A"=>nil
#  "Uo di riferimento"=>"000963"
#  "Note"=>nil
#  "Nome Tipo DG"=>"Fattura Acquisto"
#  "Data Dg"=>"25/10/2018"
#  "Numero DG"=>"257PA"
#  "Data Registrazione DG"=>"31/10/2018"
#  "Numero registrazione DG"=>"99"
#  "Edificio Collegato (Spazio)"=>nil


# "Inventario"=>"I0P4"
# "Descrizione Inventario"=>"DIPARTIMENTO DI MATEMATICA - inventario beni mobili"
# "Numero inventario"=>"2236"
# "Sub inventario"=>"0"
# "Num inventario Ateneo"=>"311788"
# "Numero buono"=>"22"
# "Data carico"=>"20/09/2018"
# "Descrizione bene"=>"Acquisto portatile per il prof. Gimigliano"
# "Valore convenzionale"=>675.88
# "Esercizio bene migrato"=>nil
# "Numero carico bene migrato"=>nil
# "Data carico migrato"=>nil
# "Codice Categoria"=>"C.02.02.17"
# "Descrizione Categoria"=>"ELABORATORI PORTATILI"
# "Codice Immobilizzazione"=>"1110"
# "Descrizione Immobilizzazione"=>"ATTREZZATURE INFORMATICHE"
# "Codice Spazio"=>"I0P4.AFFIDAMENTO"
# "Descrizione Spazio"=>"x Beni in affidamento personale (verbale di consegna)"
# "Locale"=>nil
# "Codice resp. spazio"=>nil
# "Responsabile Spazio"=>nil
# "Codice Possessore"=>nil
# "Possessore"=>nil
# "Codice Fornitore"=>"1949089"
# "Denominazione Fornitore"=>"TEAM MEMORES COMPUTER S.P.A."
# "Anno di Fabbricazione"=>"2018"
# "Numero seriale"=>"RS90Q7W7J"
# "CIB"=>nil
# "Marca"=>nil
# "Numero targa"=>nil
# "Condizione Bene"=>nil
# "Garanzia Da"=>nil
# "Garanzia A"=>nil
# "Uo di riferimento"=>"000963"
# "Note"=>"il bene sarà custodito dal prof. Gimigliano."
# "Nome Tipo DG"=>"Doc Consegna Erogazione In Entrata"
# "Data Dg"=>"11/09/2018"
# "Numero DG"=>"1497"
# "Data Registrazione DG"=>"19/09/2018"
# "Numero registrazione DG"=>"16"
# "Edificio Collegato (Spazio)"=>nil


