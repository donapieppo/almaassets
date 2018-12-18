class DsaUserInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    #o   = object.thing.deposits.map {|d| ["#{d.location} (#{d.actual} disponibili)".html_safe, d.id]}
    #dis = object.thing.deposits.map {|d| d.actual < 1 }
    #@builder.input :deposit_id, collection: o , disabled: dis, as: :radio_buttons, label: "Scegliere la provenienza"
    #template.collection_radio_buttons(:unload, :deposit_id, o, :last, :first) #{ disabled: (dep.actual < 1) }) 
    #@builder.input :user_upn
  end
end

