require "./spec_helper"
require "../lib/board"
require "../lib/player"
require 'active_support/core_ext/kernel/reporting'

describe Board do
	subject(:board) { Board.new }
	let(:player) { Player.new("Frank", "X") }

	describe "#new" do
		let(:empty_field) {
			empty_field = []
			7.times do
				empty_field.push([])
			end
			empty_field
		}

		it { expect(board.field).to eq(empty_field) }
	end

	describe "#status" do
		before { board.stub(:puts)
						 board.stub(:print) }

		it "puts" do
			board.should_receive(:puts).at_least(:once)
			board.status
		end

		it "prints" do
			board.should_receive(:print).at_least(:once)
			board.status
		end
	end

	describe "#move" do
		context "valid move" do
			let(:column) { 4 }
			let!(:valid_move) { board.move(column, player) }
			it { expect(valid_move).to be_true }
			it { expect(board.field[column - 1].last.symbol).to eq(player.symbol) }
		end

		context "invalid move" do
			context "full column" do
				before { 6.times { board.move(4, player) } }
				it { expect(board.move(4, player)).to be_false }
			end

			context "non-existing column" do
				it { expect(board.move(0, player)).to be_false }
			end
		end
	end

	describe "#has_winner" do
		context "no winner" do
			it { expect(board.has_winner).to be_nil }
		end

		context "winner" do
			context "horizontal" do
				before { board.instance_variable_set(:@field, [[],
												 				 											 [],
												 				 											 [player],
												 				 											 [player],
												 				 											 [player],
												 				 											 [player],
												 				 											 []]) }
				it { expect(board.has_winner).to eq(player) }
			end

			context "vertical" do
				before { board.instance_variable_set(:@field, [[],
												 				 											 [],
												 				 											 [player, player, player, player],
												 				 											 [],
												 				 											 [],
												 				 											 [],
												 				 											 []]) }
				it { expect(board.has_winner).to eq(player) }
			end

			context "diagonal" do
				let(:player_two) { Player.new("Two", "O") }

				before { board.instance_variable_set(:@field, [[],
												 				 											 [],
												 				 											 [player_two, player_two, player_two, player],
												 				 											 [player_two, player_two, player],
												 				 											 [player_two, player],
												 				 											 [player],
												 				 											 []]) }
				it { expect(board.has_winner).to eq(player) }
			end
		end
	end
end
