ActiveAdmin.register Topsearch do

  index :per_page => 20 do
    
    column :name                     
    default_actions  
  end
  
end
