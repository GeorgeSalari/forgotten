class User < ApplicationRecord
  before_create :confirmation_token
  has_many :listings, dependent: :destroy
  has_many :news_comments, dependent: :destroy
  mount_uploader :profile_photo, UserAvatarUploader
  has_secure_password
  enum role: [:user, :forgotten, :journalist, :admin, :superadmin]

  validates :nick_name, presence: { message: "Введите пожалуйста свой игровой логин!"}, uniqueness:
    {
      message: ->(object, data) do
        "Привет #{object.first_name}!, #{data[:value]} уже есть в нашей базе!"
      end
    }
  validates :first_name, presence: { message: "Введите пожалуйста свое имя!"}
  validates :password, presence: { message: "Введите пожалуйста пароль!"}, length: { minimum: 6, message: "Пароль должен состоять из 6 и более символов!"}, on: :create
  validates :email, presence: { message: "Введите пожалуйста почту!"}, uniqueness:
    {
      message: ->(object, data) do
        "Привет #{object.first_name}!, #{data[:value]} уже есть в нашей базе!"
      end
    }
  validates :player_link, presence: { message: "Введите пожалуйста ссылку на персонаж!"}, format: { with: /(http:\/\/)\w+\.(apeha\.ru\/info)(\.)?\w+(\?)?\w*(\=)?(\d)*(\.html)?/, message: "Неправильная ссылка на игровой персонаж" },
            uniqueness:
              {
                message: ->(object, data) do
                  "Привет #{object.first_name}!, данная ссылка уже есть в нашей базе!"
                end
              }
  def email_activate
    self.email_confirmation = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def check_errors(errors)
    if !errors.messages[:nick_name].empty?
      errors.messages[:nick_name][0]
    elsif !errors.messages[:player_link].empty?
      errors.messages[:player_link][0]
    elsif !errors.messages[:email].empty?
      errors.messages[:email][0]
    elsif !errors.messages[:password].empty?
      errors.messages[:password][0]
    else
      "Заполните пожалуйста все поля!"
    end
  end

  def full_name
    "#{self.last_name.capitalize} #{self.first_name.capitalize}"
  end

  def user_role
    case self.role
    when "user"
      "Пользователь"
    when "forgotten"
      "Забытый"
    when "journalist"
      "Журналист"
    when "admin"
      "Администратор"
    when "superadmin"
      "Суперадмин"
    end
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
