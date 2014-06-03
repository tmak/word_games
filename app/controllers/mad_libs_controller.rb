class MadLibsController < ApplicationController
  def new
    @mad_lib = MadLib.new
  end

  def create
    @mad_lib = MadLib.new(params[:mad_lib])

    respond_to do |format|
      if @mad_lib.save
        format.html  { redirect_to(@mad_lib, notice: "New Mad Lib created") }
        format.json  { render json: @mad_lib, status: :created, location: @solution }
      else
        format.html  { render "new" }
        format.json  { render json: @mad_lib.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @mad_lib = MadLib.find(params[:id])
    @solution = @mad_lib.solutions.build
  end
end
