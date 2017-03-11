Rails.application.routes.draw do
  get 'campaigns/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'campaigns/:id', to: 'campaigns#show', as: 'campaign'

  post 'campaigns/:id/pledges',       to: 'pledges#create'
  get  'campaigns/:id/pledges/:uuid', to: 'pledges#show'
  put  'campaigns/:id/pledges/:uuid', to: 'pledges#confirm'

end
