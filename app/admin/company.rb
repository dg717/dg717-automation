ActiveAdmin.register Company do
  permit_params :id, :name, :full_name, :description, :tel, :created_at, :updated_at, :chargeable, :url, :user_id

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

  index do 
    column :id
    column :name
    column :full_name
    column("user"){|c| c.user.first_name if c.user}
    column("employees"){|c| c.users.count}
    actions
  end

  show do 
    attributes_table do
    row :name
    row("user"){|a| a.user.first_name if a.user}
    row :full_name
    row :domain
    row :url
    row :description
    row :tel
    row :chargeable
    row :employees do |company|
        company.users.map(&:first_name).join("<br />").html_safe
      end
    end
  end

  form do |f|
      f.inputs "Details" do 
        f.input :name
        f.input :full_name
        f.input :domain
        f.input :url
        f.input :description
        f.input :tel
        
        f.input :user, :label => "admin", :as => :select, :collection => Company.find(f.object.id).users.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
        f.input :chargeable
        actions
      end
  end
end