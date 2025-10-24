class DailiesController < ApplicationController
  before_action :set_daily, only: [ :show, :destroy ]

  def index
    @dailies = Daily.all.order(date: :desc)
  end

  def new
  end

  def create
    file = params[:file]

    return redirect_to new_daily_path, notice: "Insérez un fichier." unless file
    return redirect_to new_daily_path, notice: "le fichier doit être au format CSV." unless file.content_type == "text/csv"

    raw_datas = read_csv(file)
    daily = Daily.new(date: raw_datas.first["datetime"], energy: daily_energy(raw_datas))

    if daily.save!
      raw_datas.each do |data|
        raw_data = RawData.new(data.to_hash)
        raw_data.daily_id = daily.id
        raw_data.save
      end
      redirect_to dailies_path, notice: "Données importées !"
    else
      redirect_to new_daily_path, notice: "Les données sont déjà présentes dans notre base."
    end
  end

  def show
  end

  def destroy
    @daily.destroy
    redirect_to dailies_path, notice: "Données supprimées !"
  end

  private

  def set_daily
    @daily = Daily.find(params[:id])
  end

  def daily_energy(raw_datas)
    array = raw_datas.map{ |e| e["energy"].to_i }
    array.sum
  end

  def read_csv(file) # get a csv file, return an array of raw datas
    array = []
    CSV.foreach(file.path, headers: true) do |row|
      array << row.to_hash
    end
    array
  end
end
