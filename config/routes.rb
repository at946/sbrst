Rails.application.routes.draw do
  get 'set',       to: 'main#set',       as: :set
  get 'brst',      to: 'main#brst',      as: :brst
  get 'matome',    to: 'main#matome',    as: :matome
  get 'result',    to: 'main#result',    as: :result
  get 'brst_fail', to: 'main#brst_fail', as: :brst_fail
  get 'share_set', to: 'main#share_set', as: :share_set

  get 'terms_of_service', to: 'common#terms_of_service',  as: :tos
  get 'privacy_policy',   to: 'common#privacy_policy',    as: :pp

  root to: 'common#top'
end
