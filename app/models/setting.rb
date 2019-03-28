class Setting
  include ActiveModel::Model

  attr_accessor :problem, :limit_time

  validates :problem, presence: true
  validates :limit_time, presence: true
  validates :limit_time, numericality: {greater_than_or_equal_to: 1, allow_blank: true, message: "は1~10分の間で入力してください"}
  validates :limit_time, numericality: {less_than_or_equal_to: 10, allow_blank: true, message: "は1~10分の間で入力してください"}

end
