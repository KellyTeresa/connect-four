require_relative "spec_helper"

RSpec.describe Game do
  context "an instance of Game" do
    let(:game) { Game.new }

    it "players start as nil" do
      expect(game.player1).to be nil
      expect(game.player2).to be nil
    end

    it "can have two players assigned" do
      game.player1 = Player.new("Foo", "X")
      game.player2 = Player.new("Bar", "0")
      expect(game.player1.name).to eq("Foo")
      expect(game.player1.token).to eq("X")
      expect(game.player2.name).to eq("Bar")
      expect(game.player2.token).to eq("0")
    end

    it "has one instance of Board" do
      expect(game.board).to be_a Board
      # can you assert something here about the state of the Board? This is still a good test.
    end

    it "starts on turn 0" do
      expect(game.turn).to eq(0)
    end
  end
end
