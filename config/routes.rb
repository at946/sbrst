Rails.application.routes.draw do
  get 'set',        to: 'main#set',       as: :set
  get 'brst',       to: 'main#brst',      as: :brst
  get 'ks',         to: 'main#ks',        as: :ks
  get 'result',     to: 'main#result',    as: :result
  get 'brst_fail',  to: 'main#brst_fail', as: :brst_fail

  get 'terms_of_service', to: 'common#terms_of_service',  as: :tos
  get 'privacy_policy',   to: 'common#privacy_policy',    as: :pp

  root to: 'common#top'
end
