Rails.application.routes.draw do
  post 'run',     to: 'main#run',     as: :run
  post 'result',  to: 'main#result',  as: :result
  get 'result',   to: 'main#result'

  # redirect to root path when users access run or result path directly.
  get 'run' => redirect("/")

  get 'terms_of_service', to: 'common#terms_of_service',  as: :terms_of_service
  get 'privacy_policy',   to: 'common#privacy_policy',    as: :privacy_policy
  root to: 'main#top'
end
