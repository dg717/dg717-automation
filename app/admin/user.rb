ActiveAdmin.register User do
  permit_params :id, :email, :first_name, :last_name, :yaroom_id, :company_id, :updated_at, :created_at, :desk_type, :avatar, :avatar_cache, user_attributes_attributes:[:title, :interest, :color]
  DESK_TYPES = [["fulltime",0],["parttime",1]]
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
    column("desk_type"){|u| DESK_TYPES[u.desk_type][0]}
    actions
  end

  show do 
    attributes_table do 
    row :first_name
    row :last_name
    row :email
    row :avatar 
    row("desk_type"){|u| DESK_TYPES[u.desk_type][0]}
    row("company"){|u| u.company.name} 
    row("interest"){|u| u.user_attributes.interest if u.user_attributes}
    row("color"){|u| u.user_attributes.favorite_color if u.user_attributes}
    row("title"){|u| u.user_attributes.title if u.user_attributes.title}
  end
  end

  form do |f|
      f.inputs "Details" do 
        f.input :first_name
        f.input :last_name
        f.input :email
        f.input :desk_type, :label=>"desk type", :as => :select, :collection => DESK_TYPES.map
        f.input :company, :label => "company", :as => :select, :collection => Company.all.map{|c| [c.name, c.id]}
        f.input :avatar, :as => :file, :hint => f.object.avatar.present? ? image_tag(f.object.avatar.url)
      : content_tag(:span, "no logo yet")
        f.input :avatar_cache, :as => :hidden 
        f.has_many :user_attributes, allow_destroy:true do |ff|
          ff.input :interest
          ff.input :favorite_color
          ff.input :title
        end
        actions
      end
  end
end
