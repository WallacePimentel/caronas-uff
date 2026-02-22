class CampusController < ApplicationController
  before_action :set_campu, only: %i[ show edit update destroy ]

  # GET /campus or /campus.json
  def index
    @campus = Campu.for_select2(
      query: params[:q], 
      limit: params[:limit]
    )

    respond_to do |format|
      format.html {
        # Filtering for active campuses in HTML view
        @campus = Campu.active.order(:description)
      }
      
      format.json {
        # Filtering with formatted results to use in select2 with JSON response
        render json: format_for_select2(@campus)
      }
    end
  end

  # GET /campus/1 or /campus/1.json
  def show
  end

  # GET /campus/new
  def new
    @campu = Campu.new
  end

  # GET /campus/1/edit
  def edit
  end

  # POST /campus or /campus.json
  def create
    @campu = Campu.new(campu_params)

    respond_to do |format|
      if @campu.save
        format.html { redirect_to @campu, notice: "Campus was successfully created." }
        format.json { render :show, status: :created, location: @campu }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @campu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campus/1 or /campus/1.json
  def update
    respond_to do |format|
      if @campu.update(campu_params)
        format.html { redirect_to @campu, notice: "Campus was successfully updated." }
        format.json { render :show, status: :ok, location: @campu }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @campu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campus/1 or /campus/1.json
  def destroy
    @campu.destroy

    respond_to do |format|
      format.html { redirect_to campus_path, status: :see_other, notice: "Campus was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_campu
      @campu = Campu.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campu_params
      params.require(:campu).permit(:description, :street_adress, :number, :district, :city, :CEP, :status)
    end
    
    # Format campuses for cleaner select2 JSON response
    def format_for_select2(campuses)
      {
        results: campuses.map do |campus|
          {
            id: campus.id,
            text: "#{campus.description} - #{campus.city}"
          }
        end
      }
    end
end