class Post < ApplicationRecord
  belongs_to :topic, :counter_cache => true, touch: true
  belongs_to :theme, :counter_cache => true, touch: true
  belongs_to :user, touch: true

  validates :content, presence: true

  after_create :set_last_post

  before_destroy :get_post_id

  after_destroy :set_last_post_before_destroy

  private
  def set_last_post
    last_post = self.as_json(include: :user)
    topic.update(last_post: last_post)
    theme.update(last_post: last_post)
  end

  def get_post_id
    @theme_id = self.theme_id
    @topic_id = self.topic_id
  end

  def set_last_post_before_destroy
    last_post_for_theme = Post.where(theme_id: @theme_id).last.as_json(include: :user)
    theme = Theme.find(@theme_id)
    theme.update(last_post: last_post_for_theme)
    last_post_for_topic = Post.where(topic_id: @topic_id).last.as_json(include: :user)
    topic = Topic.find(@topic_id)
    topic.update(last_post: last_post_for_topic)
  end
end
