Rails.application.routes.draw do
  mount Bookshelf::Engine => "/bookshelf"
  root :to => 'bookshelf/projects#index'
end
