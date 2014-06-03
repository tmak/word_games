class SolutionsController < ApplicationController
  def create
    mad_lib_id = params[:solution].delete(:mad_lib_id)
    answers = params[:solution].delete(:answers)
    @solution = MadLib.find(mad_lib_id).solutions.create(params[:solution])

    respond_to do |format|
      if @solution.save
        @solution.mad_lib.fields.each do |field|
          @solution.fill_field(field, with: (answers[field.id.to_s] || ""))
        end

        format.html  { redirect_to(@solution, notice: "Your solution has been created") }
        format.json  { render json: @solution, status: :created, location: @solution }
      else
        format.html  { render "mad_libs/new" }
        format.json  { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @solution = Solution.find(params[:id])
  end
end
