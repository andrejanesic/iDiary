class BodyEntriesController < ApplicationController
  layout 'app'
  before_action :authenticate_user!
  before_action :set_body_entry, only: %i[show edit update destroy]

  # GET /body_entries or /body_entries.json
  def index
    @body_entries = BodyEntry.where(
      diary_id: Diary.where(user_id: current_user.id).pluck(:id)
    )
  end

  # GET /body_entries/1 or /body_entries/1.json
  def show
    unless helpers.diary_belongs_to_user(@body_entry.diary_id, current_user.id)
      respond_to do |format|
        @diary.errors.add(:diary, 'does not belong to this user.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /body_entries/new
  def new
    @body_entry = BodyEntry.new
  end

  # GET /body_entries/1/edit
  def edit
    unless helpers.diary_belongs_to_user(@body_entry.diary_id, current_user.id)
      respond_to do |format|
        @diary.errors.add(:diary, 'does not belong to this user.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /body_entries or /body_entries.json
  def create
    @body_entry = BodyEntry.new(body_entry_params)
    if !helpers.diary_belongs_to_user(@body_entry.diary_id, current_user.id)
      @body_entry.errors.add(:diary, 'does not belong to this user.')
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @body_entry.errors, status: :unprocessable_entity }
      end
    else

      respond_to do |format|
        if @body_entry.save
          format.html { redirect_to body_entry_url(@body_entry), notice: 'Body entry was successfully created.' }
          format.json { render :show, status: :created, location: @body_entry }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @body_entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /body_entries/1 or /body_entries/1.json
  def update
    @body_entry = BodyEntry.new(body_entry_params)
    if !helpers.diary_belongs_to_user(@body_entry.diary_id, current_user.id)
      respond_to do |format|
        @body_entry.errors.add(:diary, 'does not belong to this user.')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @body_entry.errors, status: :unprocessable_entity }
      end
    else

      respond_to do |format|
        if @body_entry.update(body_entry_params)
          format.html { redirect_to body_entry_url(@body_entry), notice: 'Body entry was successfully updated.' }
          format.json { render :show, status: :ok, location: @body_entry }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @body_entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /body_entries/1 or /body_entries/1.json
  def destroy
    if !helpers.diary_belongs_to_user(@body_entry.diary_id, current_user.id)
      respond_to do |format|
        @body_entry.errors.add(:diary, 'does not belong to this user.')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @body_entry.errors, status: :unprocessable_entity }
      end
    else
      @body_entry.destroy

      respond_to do |format|
        format.html { redirect_to body_entries_url, notice: 'Body entry was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_body_entry
    @body_entry = BodyEntry.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def body_entry_params
    params.require(:body_entry).permit(:height, :weight, :fat_mass, :muscle_mass, :note, :timestamp, :diary_id)
  end
end
