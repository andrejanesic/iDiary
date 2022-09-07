class GoalsController < ApplicationController
  layout 'app'
  before_action :authenticate_user!
  before_action :set_goal, only: %i[show edit update destroy]
  before_action :modify_params, only: %i[create]

  # GET /goals or /goals.json
  def index
    @goals = Goal.where(user_id: current_user.id)
  end

  # GET /goals/1 or /goals/1.json
  def show
    unless helpers.goal_user_permission(@goal.id, current_user.id) >= GoalsHelper::PERMISSION_READONLY
      respond_to do |format|
        @goal.errors.add(:goal, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit
    unless helpers.goal_user_permission(@goal.id, current_user.id) >= GoalsHelper::PERMISSION_EDIT
      respond_to do |format|
        @goal.errors.add(:goal, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /goals or /goals.json
  def create
    @goal = Goal.new(goal_params)

    respond_to do |format|
      if @goal.save
        format.html { redirect_to goal_url(@goal), notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # #TODO loophole here, if user has edit perms they can include their user_id
  # and "steal" the object (transfer to their account)
  # PATCH/PUT /goals/1 or /goals/1.json
  def update
    if helpers.goal_user_permission(@goal.id, current_user.id) < GoalsHelper::PERMISSION_EDIT
      respond_to do |format|
        @goal.errors.add(:goal, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @goal.update(goal_params)
          format.html { redirect_to goal_url(@goal), notice: 'Goal was successfully updated.' }
          format.json { render :show, status: :ok, location: @goal }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @goal.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /goals/1 or /goals/1.json
  def destroy
    if helpers.goal_user_permission(@goal.id, current_user.id) < GoalsHelper::PERMISSION_OWNERSHIP
      respond_to do |format|
        @goal.errors.add(:goal, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    else
      @goal.destroy

      respond_to do |format|
        format.html { redirect_to goals_url, notice: 'Goal was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    @goal = Goal.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def goal_params
    params.require(:goal).permit(:active, :calories, :fats, :carbs, :proteins, :frequency, :user_id)
  end

  # TODO: what if creating for another user?
  # Modify to overwrite with current user id.
  def modify_params
    params[:goal][:user_id] = current_user.id
  end
end
