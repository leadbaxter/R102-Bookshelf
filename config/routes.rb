Bookshelf::Engine.routes.draw do
  resources :projects
#  get 'projects' => 'home#projects'
#  get 'project' => 'home#project'
#  post 'project/new' => 'home#project_create'
  resources :project_contents
  resources :news_items
  root :to => 'projects#index'
end
