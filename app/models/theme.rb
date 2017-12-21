class Theme < ApplicationRecord
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  belongs_to :group, touch: true

  validates :title, presence: true

  def self.set_location(gived_object)
    $location = ["Форум"]
    $location << gived_object.group.title
    $location << gived_object.group.id
    $location << gived_object.title
    $location << gived_object.id
  end
end
