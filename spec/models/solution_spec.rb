require 'spec_helper'

describe MadLib do
  describe "#fill_field" do
    it "creates an answer" do
      solution = FactoryGirl.create(:solution)

      expect {
        solution.fill_field("Cool field (4)", with: "cool answer")
      }.to change{solution.answers.count}.by(1)

      answer = solution.answers.last

      expect(answer.field_name).to eq("cool field")
      expect(answer.field_index).to eq(4)
      expect(answer.text).to eq("cool answer")
    end
  end
end
