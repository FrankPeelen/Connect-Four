require "./spec_helper"
require "../lib/player"
require 'active_support/core_ext/kernel/reporting'

describe Player do
	let(:name) { "Frank" }
	let(:symbol) { "X" }
	subject(:player) { Player.new(name, symbol) }

	describe "#new" do
		it { expect(player.name).to eq(name) }
		it { expect(player.symbol).to eq(symbol) }
	end
end
