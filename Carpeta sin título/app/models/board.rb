class Board < ApplicationRecord

belongs_to :player_one, class_name: "User"
belongs_to :player_two, class_name: "User"


has_many :cells


end
