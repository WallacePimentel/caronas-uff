class CarpoolsController < ApplicationController
  before_action :set_carpool, only: %i[ show edit update destroy ]

  # GET /carpools or /carpools.json
  def index
    @carpools = Carpool.all
  end

  # GET /carpools/1 or /carpools/1.json
  def show
  end

  # GET /carpools/new
  def new
    @carpool = Carpool.new
  end

  # GET /carpools/1/edit
  def edit
  end

  # POST /carpools or /carpools.json
  def create
    @carpool = Carpool.new(carpool_params)

    respond_to do |format|
      if @carpool.save
        format.html { redirect_to @carpool, notice: "Carpool was successfully created." }
        format.json { render :show, status: :created, location: @carpool }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @carpool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carpools/1 or /carpools/1.json
  def update
    respond_to do |format|
      if @carpool.update(carpool_params)
        format.html { redirect_to @carpool, notice: "Carpool was successfully updated." }
        format.json { render :show, status: :ok, location: @carpool }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @carpool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carpools/1 or /carpools/1.json
  def destroy
    @carpool.destroy

    respond_to do |format|
      format.html { redirect_to carpools_path, status: :see_other, notice: "Carpool was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carpool
      @carpool = Carpool.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def carpool_params
      params.require(:carpool).permit(:begging_campus_id, :ending_campus_id)
    end
end
