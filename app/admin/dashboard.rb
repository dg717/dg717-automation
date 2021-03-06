ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Current Company" do
          ul do
            Company.find_each do |company|
              table
                tr
                  div do 
                    div do 
                      h4 company.name 
                      div style:"background-color:rgba(0,0,0,0.3); padding:10px; width:600px; border-radius:20px;" do 
                        span style: "font-size:1.5em; color:white;" do
                          "#{company.monthly_usage} / #{company.monthly_allowance} used"
                        end
                        div style:"max-width: #{company.monthly_usage.to_f/company.monthly_allowance.to_f * 100}%; background-color:#{company.over_usage? ? "red" : "green"}; padding:10px; border-radius:15px;" do 
                          "　"
                        end
                      end
                    end
                  end 
            end
          end
        end
      end
    end
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
