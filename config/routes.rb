Rails.application.routes.draw do
  post 'run',     to: 'main#run',     as: :run
  post 'add',     to: 'main#add',     as: :add
  post 'result',  to: 'main#result',  as: :result

  get 'run',    to: 'main#redirect_top'
  get 'result', to: 'main#redirect_top'

  root to: 'main#top'
end
