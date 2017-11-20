class ClanMember < ApplicationRecord
  validates :race, :nick_name, :player_level, presence: true
  validates :player_link, presence: { message: "Введите пожалуйста ссылку на персонаж!"}, format: { with: /(http:\/\/)\w+\.(apeha\.ru\/info)(\.)?\w+(\?)?\w*(\=)?(\d)*(\.html)?/, message: "Неправильная ссылка на игровой персонаж" },
            uniqueness:
              {
                message: ->(object, data) do
                  "Привет #{object.first_name}!, данная ссылка уже есть в нашей базе!"
                end
              }

  def check_error
    if !self.errors.messages[:race].empty?
      "Вы не выбрали расу игрока!"
    elsif !self.errors.messages[:nick_name].empty?
      "Вы не ввели ник игрока!"
    elsif !self.errors.messages[:player_level].empty?
      "Вы не ввели уровень игрока!"
    elsif !self.errors.messages[:player_link].empty?
      self.errors.messages[:player_link][0]
    end
  end

  def self.show_members(department)
    case department
    when "all"
      ClanMember.all
    when "leadership"
      ClanMember.where(department: "Руководство")
    when "council"
      ClanMember.where(department: "Совет")
    when "programmer"
      ClanMember.where(department: "Программист")
    when "information"
      ClanMember.where(department: "Журналист")
    when "combat"
      ClanMember.where(department: "Боец")
    else
      ClanMember.all
    end
  end
end
