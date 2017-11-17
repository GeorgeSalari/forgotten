class Listing < ApplicationRecord
  belongs_to :user
  has_many :news_comments, dependent: :destroy

  validates :title, :short_content, :full_content, :user_id, presence: true

  def increase_view_count
    self.update(view_count: self.view_count += 1)
  end

  def previous_listing(id)
    id.to_i -= 1
    Listing.find(id) if Listing.exist?(id)
  end

  def next_lising(id)
    id.to_i += 1
    Listing.find(id) if Listing.exist?(id)
  end
end
