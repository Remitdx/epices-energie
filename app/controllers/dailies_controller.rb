class DailiesController < ApplicationController
  before_action :set_daily, only: [ :show, :destroy ]

  def index
    @dailies = Daily.all.order(date: :desc) # .all has preformance risks when lot's of dailies in database
  end

  def new
  end

  def create
    file = params[:file]

    return redirect_to new_daily_path, notice: "Insérez un fichier." unless file
    return redirect_to new_daily_path, notice: "Le fichier doit être au format CSV." unless file.content_type == "text/csv"

    raw_datas = read_csv(file)

    return redirect_to new_daily_path, notice: "Le fichier ne respecte pas le format attendu (3 colonnes)" unless three_column?(raw_datas)

    dailies = split_in_dailies(raw_datas)

    notice = "Données importées !"
    i = 0

    dailies.each do |daily|
      daily = Daily.new(date: dailies[i].first["datetime"].split(" ").first)

      if daily.save
        dailies[i].each do |data|
          raw_data = RawData.new()
          raw_data.identifier = data["identifier"]
          raw_data.datetime = data["datetime"].to_datetime.strftime("%F %H")
          raw_data.energy = data["energy"]
          raw_data.daily_id = daily.id
          raw_data.save
        end
        daily.update(energy: daily.total_daily_energy)
      else
        notice = "Des données étaient déjà présentes, le complément a été sauvegardé."
      end
      i += 1
    end

    redirect_to dailies_path, notice: notice
  end

  def show
    @production = @daily.energy_by_inverter
  end

  def destroy
    @daily.destroy
    redirect_to dailies_path, notice: "Données supprimées !"
  end

  private

  def how_many_days(raw_datas)
    array = raw_datas.map { |e| e["datetime"].split(" ").first }
    array.uniq!
  end

  def read_csv(file) # get a csv file, return an array of raw datas
    array = []
    CSV.foreach(file.path, headers: true) do |row|
      array << row.to_hash
    end
    array
  end

  def set_daily
    @daily = Daily.find(params[:id])
  end

  def split_in_dailies(raw_datas) # manage file with multiples days production
    days = how_many_days(raw_datas)

    days.map { |day| raw_datas.select { |data| data["datetime"].split(" ").first == day } }
  end

  def three_column?(raw_datas)
    array = raw_datas.map { |e| e.size }
    array.reject! { |e| e != 3 }
    array.size == raw_datas.size
  end
end
