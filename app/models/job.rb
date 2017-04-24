class Job < ApplicationRecord

validates :title, presence: { message: "请填写职称" }
validates :description, presence: { message: "请填写职位描述" }
validates :wage_lower_bound, presence: { message: "请填写最低薪水" }
validates :wage_upper_bound, presence: { message: "请填写最高薪水" }
validates :wage_lower_bound, numericality: { less_than: :wage_upper_bound, message: "薪水下限不能高于薪水上限" }
validates :wage_upper_bound, numericality: { greater_than: 0, message: "最小薪水必须大于零" }


belongs_to :user
has_many :resumes, dependent: :destroy
has_many :collections, dependent: :destroy
has_many :members, through: :collections, source: :user




  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }
  scope :high, -> { order('wage_upper_bound DESC')}
  scope :low, -> { order('wage_lower_bound DESC')}

end
