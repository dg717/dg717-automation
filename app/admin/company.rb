ActiveAdmin.register Company do
  permit_params :id, :name, :full_name, :description, :tel, :created_at, :updated_at

  form do |f| 
    f.inputs "Company" do
      f.input :name
      f.input :admin, :as => :select, :collection => User.all.map {|u| [u.first_name, u.id]}, :include_blank => false
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
