class ClanMember < ApplicationRecord
  validates :race, :nick_name, :player_level, presence: true
  validates :player_link, presence: { message: "Введите пожалуйста ссылку на персонаж!"}, format: { with: /(http:\/\/)\w+\.(apeha\.ru\/info)(\.)?\w+(\?)?\w*(\=)?(\d)*(\.html)?/, message: "Неправильная ссылка на игровой персонаж" },
            uniqueness:
              {
                message: ->(object, data) do
                  "Привет #{object.first_name}!, данная ссылка уже есть в нашей базе!"
                end
              }
  scope :leadership, -> { where(department: 'Руководство') }
  scope :council, -> { where(department: 'Совет') }
  scope :programmer, -> { where(department: 'Программист') }
  scope :information, -> { where(department: 'Журналист') }
  scope :combat, -> { where(department: 'Боец') }

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

  def self.order_members(department)
    array = department.split(" ")
    case array[0]
    when "member_race"
      ClanMember.department_case(array[1]).order(:race)
    when "member_nick_name"
      ClanMember.department_case(array[1]).order(:nick_name)
    when "member_level"
      ClanMember.department_case(array[1]).order(:player_level)
    when "member_post"
      ClanMember.department_case(array[1]).order(:player_post)
    when "member_city"
      ClanMember.department_case(array[1]).order(:city)
    when "member_name"
      ClanMember.department_case(array[1]).order(:name)
    end
  end

  def self.department_case(department)
    case department
    when "all"
      ClanMember.all
    when "leadership"
      ClanMember.leadership
    when "council"
      ClanMember.council
    when "programmer"
      ClanMember.programmer
    when "information"
      ClanMember.information
    when "combat"
      ClanMember.combat
    else
      ClanMember.all
    end
  end

  def self.show_members(department, order)
    if order.nil?
      ClanMember.department_case(department)
    else
      ClanMember.order_members(order)
    end
  end
end
