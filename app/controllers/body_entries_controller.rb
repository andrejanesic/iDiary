class BodyEntriesController < ApplicationController
  before_action :set_body_entry, only: %i[ show edit update destroy ]

  # GET /body_entries or /body_entries.json
  def index
    @body_entries = BodyEntry.all
  end

  # GET /body_entries/1 or /body_entries/1.json
  def show
  end

  # GET /body_entries/new
  def new
    @body_entry = BodyEntry.new
  end

  # GET /body_entries/1/edit
  def edit
  end

  # POST /body_entries or /body_entries.json
  def create
    @body_entry = BodyEntry.new(body_entry_params)

    respond_to do |format|
      if @body_entry.save
        format.html { redirect_to body_entry_url(@body_entry), notice: "Body entry was successfully created." }
        format.json { render :show, status: :created, location: @body_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @body_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /body_entries/1 or /body_entries/1.json
  def update
    respond_to do |format|
      if @body_entry.update(body_entry_params)
        format.html { redirect_to body_entry_url(@body_entry), notice: "Body entry was successfully updated." }
        format.json { render :show, status: :ok, location: @body_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @body_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /body_entries/1 or /body_entries/1.json
  def destroy
    @body_entry.destroy

    respond_to do |format|
      format.html { redirect_to body_entries_url, notice: "Body entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_body_entry
      @body_entry = BodyEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def body_entry_params
      params.require(:body_entry).permit(:weight, :height, :fat_mass, :muscle_mass, :note, :diary_id)
    end
end
