class DiariesController < ApplicationController
  layout 'app'
  before_action :authenticate_user!
  before_action :set_diary, only: %i[show edit update destroy]
  before_action :modify_params, only: %i[create]

  # GET /diaries or /diaries.json
  def index
    @diaries = Diary.where(user_id: current_user.id)
  end

  # GET /diaries/1 or /diaries/1.json
  def show
    unless helpers.diary_user_permission(@diary.id, current_user.id) >= DiariesHelper::PERMISSION_READONLY
      respond_to do |format|
        @diary.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /diaries/new
  def new
    @diary = Diary.new
  end

  # GET /diaries/1/edit
  def edit
    unless helpers.diary_user_permission(@diary.id, current_user.id) >= DiariesHelper::PERMISSION_EDIT
      respond_to do |format|
        @diary.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /diaries or /diaries.json
  def create
    @diary = Diary.new(diary_params)

    respond_to do |format|
      if @diary.save
        format.html { redirect_to diary_url(@diary), notice: 'Diary was successfully created.' }
        format.json { render :show, status: :created, location: @diary }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # #TODO loophole here, if user has edit perms they can include their user_id
  # and "steal" the object (transfer to their account)
  # PATCH/PUT /diaries/1 or /diaries/1.json
  def update
    if helpers.diary_user_permission(@diary.id, current_user.id) < DiariesHelper::PERMISSION_EDIT
      respond_to do |format|
        @diary.errors.add(:diary, 'is not shared with you.')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @diary.update(diary_params)
          format.html { redirect_to diary_url(@diary), notice: 'Diary was successfully updated.' }
          format.json { render :show, status: :ok, location: @diary }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @diary.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /diaries/1 or /diaries/1.json
  def destroy
    if helpers.diary_user_permission(@diary.id, current_user.id) < DiariesHelper::PERMISSION_OWNERSHIP
      respond_to do |format|
        @diary.errors.add(:diary, 'is not shared with you.')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    else
      @diary.destroy

      respond_to do |format|
        format.html { redirect_to diaries_url, notice: 'Diary was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_diary
    @diary = Diary.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def diary_params
    params.require(:diary).permit(:name, :user_id)
  end

  #TODO what if creating for another user?
  # Modify to overwrite with current user id.
  def modify_params
    params[:diary][:user_id] = current_user.id
  end
end
