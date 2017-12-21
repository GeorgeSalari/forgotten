class NewsComment < ApplicationRecord
  belongs_to :listing, touch: true
  belongs_to :user, touch: true
  validates :user_id, :listing_id, :content, presence: true

  def edit_content
    self.content.gsub!("цитата", "")
  end
end
