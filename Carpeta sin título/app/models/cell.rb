class Cell < ApplicationRecord

belongs_to :board

validates :turn, :position, length: {maximum: 1}


def marked?
	
end

def conditions?(user)
	user_id == user
	marked == true
end


end
