class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  belongs_to :theme, :counter_cache => true
  belongs_to :user
  belongs_to :group

  validates_presence_of :theme, :title, :content

  after_create :create_post

  before_destroy :get_theme_id

  after_destroy :set_last_post

  def self.set_location(object)
    $location = ["Форум"]
    $location << object.group.title
    $location << object.group.id
    $location << object.theme.title
    $location << object.theme.id
    $location << object.title
    $location << object.id
  end

  def increase_view_count
    self.update(views_count: (self.views_count.to_i + 1))
  end

  private
  def create_post
    self.posts.create self.attributes.slice("title", "content", "user_id", "theme_id")
  end

  def get_theme_id
    @theme_id = self.theme_id
  end

  def set_last_post
    last_post = Post.where(theme_id: @theme_id).last.as_json(include: :user)
    theme = Theme.find(@theme_id)
    theme.update(last_post: last_post)
  end
end
