class V1::CellsController < ApplicationController
skip_before_action :verify_authenticity_token, :only => [:create, :patch, :update]

def index
  render(json: Cell.all)
 end


def create
path = "/v1/cells"
cell = Cell.new(position: cell_params[:position], board_id: cell_params[:board_id])
msg , status = if cell.save
	[{position: cell.position}, 200]
	else
	[message_error(path, cell.errors.full_messages ), 400]	
	end
render(json: msg, status: status)
end

def update
path = "/v1/cells/update"
cell = Cell.find_by(position: cell_params[:position], board_id: cell_params[:board_id])

board = Board.find_by(id: cell_params[:board_id])
board.counter_turn += 1
msg , status = if board.save
	[{message:"ok"}, 200]
	else
	[message_error(path, board.errors.full_messages ), 400]	
	end
cell.marked = true
cell.user_id = cell_params[:user_id]
cell.turn = board.counter_turn
msg , status = if cell.save
	draw(cell.board_id, cell.user_id)
	else
	[message_error(path, cell.errors.full_messages ), 400]	
	end
render(json: msg, status: status)
end


def cell_params
params.require(:cell).permit(:position, :turn, :marked, :user_id, :board_id, :id)
end

def message_error (path, message)
msg = {message: [{path: path, message: message }]}
end

def victory_conditions (board_id, user_id, board)
user = User.find_by(id: user_id)
p = []
for x in [1,2,3,4,5,6,7,8,9] do
p.push(Cell.exists?(board_id: board_id, position: x, marked: true, user_id: user_id))
end

if (p[0] && p[1] && p[2]) || (p[3] && p[4] && p[5]) || (p[6] && p[7] && p[8]) || (p[0] && p[3] && p[6]) || (p[1] && p[4] && p[7]) || (p[2] && p[5] && p[8]) || (p[0] && p[4] && p[8]) || (p[6] && p[4] && p[2])

board.result = "winner is user " + user.nickname
msg , status = if board.save
	[{result: {result: board.result ,user_id: user.id}}, 200]
	else
	[message_error(path, board.errors.full_messages ), 400]	
	end
	else
	[{result: "ok"}, 200]
end
end

def draw(board_id, user_id)
board = Board.find_by(id: board_id)
	if board.counter_turn == 9 &&  !victory_conditions(board_id, user_id, board) 
	board.result = "draw"
	msg , status = if board.save
		[{result: board.result }, 200]
		else
		[message_error(path, board.errors.full_messages ), 400]	
		end	
	else
		victory_conditions(board_id, user_id, board) 	
	end
end


end
