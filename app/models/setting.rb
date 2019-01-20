class Setting
  include ActiveModel::Model

  attr_accessor :problem, :limit_time

  validates :problem, presence: true
  validates :limit_time, presence: true
  validates :limit_time, numericality: {greater_than_or_equal_to: 1, message: "は1分以上に設定してください"}
  validates :limit_time, numericality: {less_than_or_equal_to: 10, message: "は10分以下に設定してください"}

end
