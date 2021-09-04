class V1::BoardsController < ApplicationController
skip_before_action :verify_authenticity_token, :only => [:create]

def index
  render(json: Board.all)
 end

def create
path = "/v1/boards"
board = Board.new(board_params)
msg , status = if board.save
	[{result: "todo salio bien"}, 200]
	else
	[message_error(path, board.errors.full_messages ), 400]	
	end
for x in [1,2,3,4,5,6,7,8,9] do
cell = Cell.new(position: x, board_id: board.id)
msg , status = if cell.save
	[{id: board.id }, 200]
	else
	[message_error(path, cell.errors.full_messages ), 400]	
	end
end
render(json: msg, status: status)
end


def board_params
params.require(:board).permit(:player_one_id, :player_two_id)
end



def message_error (path, message)
msg = {message: [{path: path, message: message }]}
end

end
