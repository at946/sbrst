Rails.application.routes.draw do
  post 'run',     to: 'main#run',     as: :run
  post 'add',     to: 'main#add',     as: :add
  post 'result',  to: 'main#result',  as: :result

  get 'run',    to: 'main#redirect_top'
  # get 'run', to: 'main#run'
  get 'result', to: 'main#redirect_top'
  # get 'result', to: 'main#result'

  get 'terms_of_service', to: 'main#terms_of_service',  as: :terms_of_service
  get 'privacy_policy',   to: 'main#privacy_policy',    as: :privacy_policy
  root to: 'main#top'
end
