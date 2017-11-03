class User < ApplicationRecord
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

  def user_birthday
    case self.birthday.month
    when 1
      month = "Января"
    when 2
      month = "Февраля"
    when 3
      month = "Марта"
    when 4
      month = "Апреля"
    when 5
      month = "Мая"
    when 6
      month = "Июня"
    when 7
      month = "Июля"
    when 8
      month = "Августа"
    when 9
      month = "Сентября"
    when 10
      month = "Октября"
    when 11
      month = "Ноября"
    when 12
      month = "Декабря"
    end
    "#{self.birthday.day} #{month} #{self.birthday.year}г."
  end
end
