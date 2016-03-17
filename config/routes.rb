Rails.application.routes.draw do
  get 'member/index'

  get '/events/preview' => 'events#preview'
  resources :events

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"
  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end
end
