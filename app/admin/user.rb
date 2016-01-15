ActiveAdmin.register User do
  permit_params :id, :email, :first_name, :last_name, :yaroom_id, :company_id, :updated_at, :created_at, :desk_type

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
    column :email
    column("user"){|u| u.first_name + " " + u.last_name }
    column("company"){|u| u.company.name}
    column("desk_type"){|u| u.desk_type == 0 ? "fulltime" : "parttime"}
    actions
  end

  form do |f|
      f.inputs "Details" do 
        f.input :first_name
        f.input :last_name
        f.input :email
f.input :desk_type
        f.input :company, :label => "company", :as => :select, :collection => Company.all.map{|c| [c.name, c.id]}
        actions
      end
  end
end
