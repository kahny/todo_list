Rails.application.routes.draw do
  #review
  resources :todo_items, except: [:new, :edit]
  match "*path", to: "todo_items#index", via: "get"
  root 'todo_items#index'
end
