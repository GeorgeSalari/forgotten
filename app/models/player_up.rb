class PlayerUp < ApplicationRecord
  belongs_to :player_level, touch: true
end
