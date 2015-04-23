class Board
	attr_reader :field

	def initialize
		@field = []
		7.times do
			@field.push([])
		end
	end

	def status
		puts "Connect Four Board Status:"
		5.downto(0).each do |i|
			print "\nRow#{i + 1}: "
			0.upto(6).each do |j|
				if field[j].size > i
					print "#{field[j][i].symbol}"
				else
					print "-"
				end
				print " "
			end
		end
		print "\n\n"
	end

	def move(column, player)
		return false unless move_is_valid?(column)
		@field[column - 1].push(player)
	end

	def has_winner
		horizontal_connect || vertical_connect || diagonal_connect
	end

	private
	def move_is_valid?(column)
		column > 0 && column <= 7 && @field[column - 1].size < 6
	end

	def horizontal_connect
		for i in 0..5
			player = nil
			count = 0
			for j in 0..6
				column = @field[j]
				player_in_field = column.size > i ? column[i] : nil
				if player_in_field == player && !player.nil?
					return player if count == 3
					count += 1
				elsif !player_in_field.nil?
					player = player_in_field
					count = 1
				else
					player = nil
					count = 0
				end
			end
		end
		return nil
	end

	def vertical_connect
		@field.each do |column|
			player = nil
			count = 0
			column.each do |player_in_field|
				if player_in_field == player && !player.nil?
					return player if count == 3
					count += 1
				elsif !player_in_field.nil?
					player = player_in_field
					count = 1
				else
					player = nil
					count = 0
				end
			end
		end
		return nil
	end

	def diagonal_connect
		left_to_right_starts = [[0, 2], [0, 1], [0, 0], [1, 0], [2, 0], [3, 0]]
		left_to_right_starts.each do |start|
			player = nil
			count = 0
			start[1].upto(5).each do |y|
				x = start[0] + y - start[1]
				next if x > 6
				column =  @field[x]
				player_in_field = column.size > y ? column[y] : nil
				if player_in_field == player && !player.nil?
					return player if count == 3
					count += 1
				elsif !player_in_field.nil?
					player = player_in_field
					count = 1
				else
					player = nil
					count = 0
				end
			end
		end
		right_to_left_starts = [[3, 0], [4, 0], [5, 0], [6, 0], [6, 1], [6, 2]]
		right_to_left_starts.each do |start|
			player = nil
			count = 0
			start[1].upto(5).each do |y|
				x = start[0] - y + start[1]
				next if x > 6
				column =  @field[x]
				player_in_field = column.size > y ? column[y] : nil
				if player_in_field == player && !player.nil?
					return player if count == 3
					count += 1
				elsif !player_in_field.nil?
					player = player_in_field
					count = 1
				else
					player = nil
					count = 0
				end
			end
		end
		return nil
	end
end
