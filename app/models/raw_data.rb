class RawData < ApplicationRecord
  belongs_to :daily

  validates :identifier, :datetime, :energy, presence: true
  validates :datetime, uniqueness: { scope: :identifier,
    message: "cette donnée existe déja dans notre base." }
end
