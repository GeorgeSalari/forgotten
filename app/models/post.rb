class Post < ApplicationRecord
  belongs_to :topic, :counter_cache => true
  belongs_to :theme, :counter_cache => true
  belongs_to :user

  validates :content, presence: true

  after_create :set_last_post

  private
  def set_last_post
    last_post = self.as_json(include: [:topic, :user])
    topic.update(last_post: last_post)
    theme.update(last_post: last_post)
  end
end
