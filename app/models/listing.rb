class Listing < ApplicationRecord
  belongs_to :user, touch: true
  has_many :news_comments, dependent: :destroy

  validates :title, :short_content, :full_content, :user_id, presence: true

  def increase_view_count
    self.update(view_count: self.view_count += 1)
  end

  def previous_listing(id)
    id = id.to_i
    id -= 1
    while id >= 1
      if Listing.exists?(id)
        result = Listing.find(id)
        break
      end
      id -= 1
    end
    result
  end

  def next_lising(id)
    id = id.to_i
    id += 1
    while id <= Listing.last.id
      if Listing.exists?(id)
        result = Listing.find(id)
        break
      end
      id += 1
    end
    result
  end
end
