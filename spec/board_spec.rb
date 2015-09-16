require_relative "spec_helper"

RSpec.describe Board do
  # good tests here!
  context "an instance of Board" do
    let(:board) { Board.new }
    it "has 6 rows" do
      expect(board.grid_array.length).to eq 6
    end

    it "has 7 columns" do
      expect(board.grid_array[0].length).to eq 7
    end
  end
end
