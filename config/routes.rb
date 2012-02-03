Bookshelf::Engine.routes.draw do
  resources :projects
  resources :news_items
  root :to => 'projects#index'
end
