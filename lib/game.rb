require_relative "player"
require_relative "board"

class Game
	def initialize
		@board = Board.new
	end

	def play
		player_one = new_player(1, "X")
		player_two = new_player(2, "O")
		moves = 1
		until @board.has_winner
			moves % 2 == 1 ? move(player_one) : move(player_two)
			moves += 1
		end
		@board.status
		puts "Congratulations, #{@board.has_winner.name}!! You have won!!"
	end

	private
	def new_player(num, symbol)
		puts "Please enter player#{num}'s name:"
		Player.new(gets.chomp, symbol)
	end

	def move(player)
		@board.status
		puts "Please enter the number of the column of your next move."
		input = get_int_input
		valid = input.is_a?(Integer) && @board.move(input, player)
		until valid
			puts "A valid move could not be made in the column you selected, please try again."
			input = get_int_input
			valid = input.is_a?(Integer) && @board.move(input, player)
		end
	end

	def get_int_input
		begin
			Integer(gets.chomp)
		rescue ArgumentError
			nil
		end
	end
end

#game = Game.new
#game.play
