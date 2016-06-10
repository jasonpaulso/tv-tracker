class Show < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :user_shows
  has_many :users, through: :user_shows
  belongs_to :network
  has_many :show_actors
  has_many :actors, through: :show_actors
  validates :title, presence: true
  validates :description, presence: true



  def network_attributes=(network_attributes)
    network = Network.find_or_create_by(name:network_attributes[:name])
    self.network = network
  end


  def rating
    self.user_shows.count
  end

  def self.most_popular_show
    self.joins(:user_shows).group("show_id").order("COUNT(*) DESC").limit(1).take
  end

end
