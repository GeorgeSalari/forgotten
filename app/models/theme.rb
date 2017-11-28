class Theme < ApplicationRecord
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  belongs_to :group

  validates :title, presence: true

  def self.set_location(object)
    $location = ["Форум"]
    $location << object.group.title
    $location << object.group.id
    $location << object.title
    $location << object.id
  end
end
