class ExerciseEntriesController < ApplicationController
  layout 'app'
  before_action :authenticate_user!
  before_action :set_exercise_entry, only: %i[show edit update destroy]

  # GET /exercise_entries or /exercise_entries.json
  def index
    d_id = nil
    from = nil # from comes chronologically before to
    to = nil

    if params.has_key?(:from) && params.has_key?(:to)
      if (params[:from].to_i < 0 || params[:to].to_i < 0) ||
         (params[:from].to_i < params[:to].to_i) ||
         (params[:from].to_i > 10_000 || params[:to].to_i > 10_000)

        respond_to do |format|
          format.html { render :index, status: :unprocessable_entity }
          format.json { render json: { "range": 'from and to must be >= 0' }, status: :unprocessable_entity }
        end
        return
      else
        from = params[:from].to_i
        to = params[:to].to_i
      end
    end

    d_id = if params[:diary_id] && params[:diary_id].to_i >= 0 &&
              helpers.diary_belongs_to_user(params[:diary_id].to_i, current_user.id)
             params[:diary_id]
           else
             Diary.where(user_id: current_user.id).pluck(:id)
           end

    unless from.nil?
      @exercise_entries = ExerciseEntry.where(
        '(timestamp BETWEEN ? AND ?) AND diary_id IN (?)',
        DateTime.now - from,
        DateTime.now - to,
        d_id
      ).order('timestamp DESC')
      # TODO: šta ako nema ni jedan?
      # TODO šta ako ima samo jedan?
      @exercise_entries_total = ((ExerciseEntry.where(diary_id: d_id).order('timestamp DESC')[0].timestamp -
        ExerciseEntry.where(diary_id: d_id).order('timestamp DESC')[-1].timestamp
                             ) / (60 * 60 * 24)).round
      return
    end

    @exercise_entries = ExerciseEntry.where(diary_id: d_id).order('timestamp DESC')
  end

  # GET /exercise_entries/1 or /exercise_entries/1.json
  def show
    unless helpers.diary_belongs_to_user(@exercise_entry.diary_id, current_user.id)
      respond_to do |format|
        @exercise_entry.errors.add(:diary, 'does not belong to this user.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @exercise_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /exercise_entries/new
  def new
    @exercise_entry = ExerciseEntry.new
  end

  # GET /exercise_entries/1/edit
  def edit
    unless helpers.diary_belongs_to_user(@exercise_entry.diary_id, current_user.id)
      respond_to do |format|
        @exercise_entry.errors.add(:diary, 'does not belong to this user.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @exercise_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /exercise_entries or /exercise_entries.json
  def create
    @exercise_entry = ExerciseEntry.new(exercise_entry_params)
    if !helpers.diary_belongs_to_user(@exercise_entry.diary_id, current_user.id)
      @exercise_entry.errors.add(:diary, 'does not belong to this user.')
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exercise_entry.errors, status: :unprocessable_entity }
      end
    else

      respond_to do |format|
        if @exercise_entry.save
          format.html { redirect_to exercise_entry_url(@exercise_entry), notice: 'Fitness entry was successfully created.' }
          format.json { render :show, status: :created, location: @exercise_entry }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @exercise_entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /exercise_entries/1 or /exercise_entries/1.json
  def update
    if !helpers.diary_belongs_to_user(@exercise_entry.diary_id, current_user.id)
      respond_to do |format|
        @exercise_entry.errors.add(:diary, 'does not belong to this user.')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exercise_entry.errors, status: :unprocessable_entity }
      end
    else

      respond_to do |format|
        if @exercise_entry.update(exercise_entry_params)
          format.html { redirect_to exercise_entry_url(@exercise_entry), notice: 'Fitness entry was successfully updated.' }
          format.json { render :show, status: :ok, location: @exercise_entry }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @exercise_entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /exercise_entries/1 or /exercise_entries/1.json
  def destroy
    if !helpers.diary_belongs_to_user(@exercise_entry.diary_id, current_user.id)
      respond_to do |format|
        @exercise_entry.errors.add(:diary, 'does not belong to this user.')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exercise_entry.errors, status: :unprocessable_entity }
      end
    else
      @exercise_entry.destroy

      respond_to do |format|
        format.html { redirect_to exercise_entries_url, notice: 'Fitness entry was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_entry
      @exercise_entry = ExerciseEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exercise_entry_params
      params.require(:exercise_entry).permit(:complete, :note, :timestamp, :diary_id)
    end
end
