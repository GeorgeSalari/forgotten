class Group < ApplicationRecord
  include UsersHelper
  has_many :themes, ->{order(:id)}, dependent: :destroy
  has_many :topics, through: :themes, dependent: :destroy
  has_many :posts, through: :topics, dependent: :destroy

  validates :title, presence: true

  def self.set_location
    $location = ["Форум"]
  end

  def self.set_location_show(object)
    $location = ["Форум"]
    $location << object.title
    $location << object.id
  end

end
