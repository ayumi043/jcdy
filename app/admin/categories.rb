ActiveAdmin.register Category, :as => 'leibie' do

  # binding.pry

  index :per_page => 20 do
    
    column :name                     
    column :sortid
    default_actions  
  end

  form do |f|                         
    f.inputs "Category Details" do       
      f.input :name                  
      f.input :sortid  
    end                               
    f.actions                         
  end     

end
