require_relative "spec_helper"

RSpec.describe Player do
  context "an instance of Player" do
    let(:foo) { Player.new("Foo", "X") }
    let(:bar) { Player.new("Bar", "0") }
    it "has a name" do
      expect(foo.name).to eq("Foo")
    end
    it "is assigned a token type" do
      expect(foo.token).to eq("X")
    end
  end
end
