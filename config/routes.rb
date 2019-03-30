Rails.application.routes.draw do
  post 'set',       to: 'main#set',       as: :set
  post 'brst',      to: 'main#brst',      as: :brst
  post 'ks',         to: 'main#ks',        as: :ks
  post 'result',     to: 'main#result',    as: :result
  post 'brst_fail',  to: 'main#brst_fail', as: :brst_fail

  get 'set'       => redirect("/")
  get 'brst'      => redirect("/")
  get 'ks'        => redirect("/")
  get 'result'    => redirect("/")
  get 'brst_fail' => redirect("/")

  get 'terms_of_service', to: 'common#terms_of_service',  as: :tos
  get 'privacy_policy',   to: 'common#privacy_policy',    as: :pp

  root to: 'common#top'
end
