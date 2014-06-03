class ReportsController < ApplicationController
  def index
    @usage = Answer.count(group: :field_type)
    @answers = Answer.where("text <> ''").count(group: :text)
  end
end
