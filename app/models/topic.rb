class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  belongs_to :theme, :counter_cache => true
  belongs_to :user

  validates_presence_of :theme, :title, :content

  after_create :create_post

  before_destroy :set_last_post

  def increase_view_count
    self.update(views_count: (self.views_count.to_i + 1))
  end

  private
  def create_post
    self.posts.create self.attributes.slice("title", "content", "user_id", "theme_id")
  end

  def set_last_post
    last_post = Post.where(theme_id: self.theme_id).last.as_json(include: :user)
    theme = Theme.find(self.theme_id)
    theme.update(last_post: last_post)
  end
end
