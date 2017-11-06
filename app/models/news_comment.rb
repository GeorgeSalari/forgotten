class NewsComment < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  validates :user_id, :listing_id, :content, presence: true

  def edit_content
    self.content.gsub!("цитата", "")
  end
end
