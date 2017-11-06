class Listing < ApplicationRecord
  belongs_to :user
  has_many :news_comments, dependent: :destroy

  validates :title, :short_content, :full_content, :user_id, presence: true

  def increase_view_count
    self.update(view_count: self.view_count += 1)
  end

  def previous_listing(id)
    Listing.find(id.to_i - 1) if id.to_i > 1
  end

  def next_lising(id)
    Listing.find(id.to_i + 1) if id.to_i < Listing.all.count
  end
end
