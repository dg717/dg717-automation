ActiveAdmin.register Company do
  permit_params :id, :name, :full_name, :description, :tel, :created_at, :updated_at, :chargeable, :url, :user_id, :domain, :company_type, :logo, :logo_cache, :special_pricing, users_attributes: [:id, :first_name, :last_name, :email]
  COMPANY_TYPES = [["Normal",0],["Scrum",1],["Portfolio",2],["Old Pricing",3],["Other",4],["DG",5]]
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
    column("type"){|c| COMPANY_TYPES[c.company_type][0] if c.company_type}
    column("admin"){|c| c.user.first_name if c.user}
    column("employees"){|c| c.users.count}
    column ("total_rent") {|c| c.total_rent}
    actions
  end

  show do 
    attributes_table do
    row :name
    row("rent"){|a| a.total_rent}
    row("user"){|a| a.user.first_name if a.user}
    row :full_name
    row :domain
    row :url
    row :description
    #row :company_type
    row("company_type"){|c| COMPANY_TYPES[c.company_type][0]}
    row :tel
    row :chargeable
    row :special_pricing
    row :employees do |company|
        company.users.map(&:first_name).join("<br />").html_safe
      end
    end
  end

  form do |f|
      f.inputs "Details" do 
        f.input :name
        f.input :full_name
        f.input :logo, :as => :file, :hint => f.object.logo.present? ? image_tag(f.object.logo.url)
    : content_tag(:span, "no logo yet")
        f.input :logo_cache, :as => :hidden 
        f.input :domain
        f.input :url
        f.input :description
        f.input :company_type, :label => "type", :as => :select, :collection => COMPANY_TYPES.map
        unless f.object.new_record?
          f.input :user, :label => "admin", :as => :select, :collection => Company.find(f.object.id).users.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
        end
        if f.object.new_record?
           f.has_many :users, allow_destroy:true do |ff|
            ff.input :first_name
            ff.input :last_name
            ff.input :email
          end
        end 
        f.input :chargeable
        f.input :special_pricing, input_html: { placeholder: "Enter message here" }
        actions
      end
  end
end