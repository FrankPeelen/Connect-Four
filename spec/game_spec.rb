require "./spec_helper"
require "../lib/player"
require "../lib/board"
require "../lib/game"
require 'active_support/core_ext/kernel/reporting'

describe Game do
	subject(:game) { Game.new }

	describe "#new" do
		it { expect(game.instance_variable_get(:@board)).not_to be_nil }
	end

	describe "#play" do
		let(:player) { Player.new("Frank", "X") }
		let(:board) { game.instance_variable_get(:@board) }
		before {
			game.stub(:new_player).and_return(player)
			game.stub(:move) { board.instance_variable_set(:@field, [[],
																															 [],
																															 [player],
																															 [player],
																															 [player],
																															 [player],
																															 []]) }
			board.stub(:puts)    # Doesn't seem to work
			game.stub(:puts)
			game.play
		}

		it { expect(board.has_winner).to be_true }
	end
end
