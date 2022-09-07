class DiarySharesController < ApplicationController
  layout 'app'
  before_action :authenticate_user!
  before_action :set_diary_share, only: %i[show edit update destroy]

  # If the target user has access any level of access (LA) between
  # PERMISSION_READONLY <= LA < PERMISSION_OWNERSHIP, he will be able to see
  # this object. If the target user has PERMISSION_OWNERSHIP, he can edit it
  # as well.

  # GET /diary_shares or /diary_shares.json
  def index
    @diary_shares = DiaryShare.where(
      # where shared with user or it's a current user's diary
      '(user_id = ?) OR (diary_id IN (?))',
      current_user.id,
      Diary.where(user_id: current_user.id).pluck('id')
    )
  end

  # GET /diary_shares/1 or /diary_shares/1.json
  def show
    unless helpers.diary_user_permission(@diary_share.diary_id, current_user.id) >= DiariesHelper::PERMISSION_READONLY
      respond_to do |format|
        @diary_share.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @diary_share.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /diary_shares/new
  def new
    @diary_share = DiaryShare.new
  end

  # GET /diary_shares/1/edit
  def edit
    unless helpers.diary_user_permission(@diary_share.diary_id, current_user.id) >= DiariesHelper::PERMISSION_OWNERSHIP
      respond_to do |format|
        @diary_share.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @diary_share.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /diary_shares or /diary_shares.json
  def create
    @diary_share = DiaryShare.new(diary_share_params)
    if helpers.diary_user_permission(@diary_share.diary_id, current_user.id) < DiariesHelper::PERMISSION_OWNERSHIP
      @diary_share.errors.add(:diary, 'is not shared with you.')
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diary_share.errors, status: :unprocessable_entity }
      end
    else

      respond_to do |format|
        if @diary_share.save
          format.html { redirect_to diary_share_url(@diary_share), notice: 'Diary share was successfully created.' }
          format.json { render :show, status: :created, location: @diary_share }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @diary_share.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /diary_shares/1 or /diary_shares/1.json
  def update
    if helpers.diary_user_permission(@diary_share.diary_id, current_user.id) < DiariesHelper::PERMISSION_OWNERSHIP
      @diary_share.errors.add(:diary, 'is not shared with you.')
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diary_share.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @diary_share.update(diary_share_params)
          format.html { redirect_to diary_share_url(@diary_share), notice: 'Diary share was successfully updated.' }
          format.json { render :show, status: :ok, location: @diary_share }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @diary_share.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /diary_shares/1 or /diary_shares/1.json
  def destroy
    if helpers.diary_user_permission(@diary_share.diary_id, current_user.id) < DiariesHelper::PERMISSION_OWNERSHIP
      @diary_share.errors.add(:diary, 'is not shared with you.')
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diary_share.errors, status: :unprocessable_entity }
      end
    else
      @diary_share.destroy

      respond_to do |format|
        format.html { redirect_to diary_shares_url, notice: 'Diary share was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_diary_share
    @diary_share = DiaryShare.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def diary_share_params
    params.require(:diary_share).permit(:permission, :diary_id, :user_id)
  end
end
