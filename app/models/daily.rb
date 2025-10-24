class Daily < ApplicationRecord
  has_many :raw_datas, dependent: :destroy

  validates :date, :energy, presence: true
  validates :date, uniqueness: true
end
