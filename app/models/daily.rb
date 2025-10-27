class Daily < ApplicationRecord
  has_many :raw_datas, dependent: :destroy

  validates :date, presence: true
  validates :date, uniqueness: true

  # construct a bi-dimensionnal array to separate each inverter production within the daily production,
  # also fill missing data with nil value
  def energy_by_inverter
    array = self.raw_datas
    identifiers = find_identifiers(array)

    organized_array = identifiers.map { |id| array.select { |data| data.identifier == id } }
    filled_array = organized_array.map { |inverter| fill_with_nil_values(inverter) }
  end

  def total_daily_energy
    array = self.raw_datas.map { |e| e["energy"].to_i }
    array.sum
  end

  private

  def fill_with_nil_values(array)
    res = []
    for i in 0..23 do
      if array.any? { |e| e["datetime"].strftime("%k").to_i == i }
      res << array.find { |e| e["datetime"].strftime("%k").to_i == i }
      else
        res << nil
      end
    end
    res
  end

  def find_identifiers(datas)
    arr = datas.map { |e| e.identifier }
    arr.uniq
  end
end
