class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    # binding.pry
    # all.includes(boats: [:classifications]).where(classifications: { name: "Catamaran" } ).group(:captain_id)

    joins(:classifications).where("classifications.name = 'Catamaran'").group(:captain_id)

  end

  def self.sailors
    # all.includes(boats: [:classifications]).where(classifications: { name: "Sailboat" } ).group(:captain_id)

    joins(:classifications).where("classifications.name = 'Sailboat'").group(:captain_id)
  end

  def self.talented_seamen

    joins(:classifications).where("classifications.name = 'Sailboat' OR classifications.name = 'Motorboat'").group("classifications.name").order(:name)
  end

  def self.non_sailors
    # joins(:classifications).where("classifications.name = 'Catamaran'").group(:captain_id)
    ids = sailors.pluck(:id)
    all.where.not(id: ids)
  end

end
