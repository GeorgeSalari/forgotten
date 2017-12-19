class PlayerLevel < ApplicationRecord
  has_many :player_ups

  def self.check_gived_experience(gived_experience, gived_level)
    result = []

    # find player level
    player_level = self.where('experience <= ?', gived_experience).last
    result << player_level.level

    # return gived experience
    result << gived_experience.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")

    # find player up
    unless player_level.player_ups.where('experience <= ?', gived_experience).last.nil?
        player_up = player_level.player_ups.where('experience <= ?', gived_experience).last
        result << player_up.up
    else
        player_up = 0
        result << player_up
    end

    # experience to next up
    # find next up
    if player_up.up
        unless PlayerUp.find_by(player_level_id: player_level.id, up: player_up.up + 1).nil?
            next_up = PlayerUp.find_by(player_level_id: player_level.id, up: player_up.up + 1)
        else
            next_up = PlayerLevel.find_by(level: player_level.level+1)
        end
    else
        next_up = PlayerUp.find_by(player_level_id: player_level.id, up: player_up + 1)
    end
    next_up_exp = next_up.experience - gived_experience.to_i
    result << next_up_exp.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")

    # up finish, find %
    # total exp for up
    if player_up.up
        total_exp = next_up.experience - player_up.experience
        pass_exp = gived_experience.to_i - player_up.experience
    else
        total_exp = next_up.experience - player_level.experience
        pass_exp = gived_experience.to_i - player_level.experience
    end
    percent_up_exp = pass_exp.to_f / total_exp * 100
    result << "#{percent_up_exp.round}%"

    # experience to next level
    next_level = self.find(player_level.id + 1)
    exp_to_next_level = next_level.experience - gived_experience.to_i
    result << exp_to_next_level.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")

    # level finish, find %
    # total exp for level
    total_level_exp = next_level.experience - player_level.experience
    pass_level_exp = gived_experience.to_i - player_level.experience
    percent_level_exp = pass_level_exp.to_f / total_level_exp * 100
    result << "#{percent_level_exp.round}%"

    # money next up
    result << next_up.money.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")

    # remain money to next level
    up_passed = player_level.player_ups.where('experience <= ?', gived_experience)
    result << (next_level.money - up_passed.sum(:money)).to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")


    # money for thih level
    result << next_level.money.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")

    # total money
    level_passed = PlayerLevel.where("level <= ?", player_level.level)
    total_money = (level_passed.sum(:money) + up_passed.sum(:money)).to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")

    result << total_money

    # calc all stats
    up_passed_for_stats = PlayerUp.where('experience <= ?', gived_experience)
    total_stats = level_passed.sum(:stat) + up_passed_for_stats.sum(:stat)

    result << total_stats

    # experience to desired level
    unless gived_level.empty?
      desired_level = PlayerLevel.find_by(level: gived_level.to_i)
      result << (desired_level.experience - gived_experience.to_i).to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")
    else
      result << "-"
    end

    result
  end
end
