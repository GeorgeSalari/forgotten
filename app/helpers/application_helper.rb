module ApplicationHelper
  def russian_date(gived_date)
    case gived_date.month
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
    "#{gived_date.day} #{month} #{gived_date.year}г."
  end
end
