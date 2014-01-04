NyplTweetwall::Application.routes.draw do
  root :to => 'content_items#index'

  get 'api/content_items/:category' => 'api/content_items#index'
end
