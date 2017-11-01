class User < ApplicationRecord
  has_secure_password
  enum role: [:user, :forgotten, :journalist, :admin, :superadmin]

  validates :nick_name, presence: { message: "Введите пожалуйста свой игровой логин!"}, uniqueness:
    {
      message: ->(object, data) do
        "Привет #{object.first_name}!, #{data[:value]} уже есть в нашей базе!"
      end
    }
  validates :first_name, presence: { message: "Введите пожалуйста свое имя!"}
  validates :password, presence: { message: "Введите пожалуйста пароль!"}, length: { minimum: 6, message: "Пароль должен состоять из 6 и более символов!"}
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
end
