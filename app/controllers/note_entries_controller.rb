class NoteEntriesController < ApplicationController
  layout 'app'
  before_action :authenticate_user!
  before_action :set_note_entry, only: %i[show edit update destroy]

  # GET /note_entries or /note_entries.json
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
              helpers.diary_user_permission(params[:diary_id].to_i,
                                            current_user.id) >= DiariesHelper::PERMISSION_READONLY
             params[:diary_id]
           else
             Diary.where(user_id: current_user.id).pluck(:id)
           end

    unless from.nil?
      @note_entries = NoteEntry.where(
        '(timestamp BETWEEN ? AND ?) AND diary_id IN (?)',
        DateTime.now - from,
        DateTime.now - to,
        d_id
      ).order('timestamp DESC')
      # TODO: šta ako nema ni jedan?
      # TODO šta ako ima samo jedan?
      @note_entries_total = ((NoteEntry.where(diary_id: d_id).order('timestamp DESC')[0].timestamp -
        NoteEntry.where(diary_id: d_id).order('timestamp DESC')[-1].timestamp
                             ) / (60 * 60 * 24)).round
      return
    end

    @note_entries = NoteEntry.where(diary_id: d_id).order('timestamp DESC')
  end

  # GET /note_entries/1 or /note_entries/1.json
  def show
    unless helpers.diary_user_permission(@note_entry.diary_id, current_user.id) >= DiariesHelper::PERMISSION_READONLY
      respond_to do |format|
        @note_entry.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @note_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /note_entries/new
  def new
    @note_entry = NoteEntry.new
  end

  # GET /note_entries/1/edit
  def edit
    unless helpers.diary_user_permission(@note_entry.diary_id, current_user.id) >= DiariesHelper::PERMISSION_EDIT
      respond_to do |format|
        @note_entry.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @note_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /note_entries or /note_entries.json
  def create
    @note_entry = NoteEntry.new(note_entry_params)
    if helpers.diary_user_permission(@note_entry.diary_id, current_user.id) < DiariesHelper::PERMISSION_EDIT
      @note_entry.errors.add(:diary, 'is not shared with you.')
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note_entry.errors, status: :unprocessable_entity }
      end
    else

      respond_to do |format|
        if @note_entry.save
          format.html { redirect_to note_entry_url(@note_entry), notice: 'Note entry was successfully created.' }
          format.json { render :show, status: :created, location: @note_entry }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @note_entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /note_entries/1 or /note_entries/1.json
  def update
    if helpers.diary_user_permission(@note_entry.diary_id, current_user.id) < DiariesHelper::PERMISSION_EDIT
      respond_to do |format|
        @note_entry.errors.add(:diary, 'is not shared with you.')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note_entry.errors, status: :unprocessable_entity }
      end
    else

      respond_to do |format|
        if @note_entry.update(note_entry_params)
          format.html { redirect_to note_entry_url(@note_entry), notice: 'Note entry was successfully updated.' }
          format.json { render :show, status: :ok, location: @note_entry }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @note_entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /note_entries/1 or /note_entries/1.json
  def destroy
    if helpers.diary_user_permission(@note_entry.diary_id, current_user.id) < DiariesHelper::PERMISSION_OWNERSHIP
      respond_to do |format|
        @note_entry.errors.add(:diary, 'is not shared with you.')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note_entry.errors, status: :unprocessable_entity }
      end
    else
      @note_entry.destroy

      respond_to do |format|
        format.html { redirect_to note_entries_url, notice: 'Note entry was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note_entry
    @note_entry = NoteEntry.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_entry_params
    params.require(:note_entry).permit(:note, :timestamp, :diary_id)
  end
end