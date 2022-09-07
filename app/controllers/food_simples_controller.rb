class FoodSimplesController < ApplicationController
  layout 'app'
  before_action :authenticate_user!
  before_action :set_food_simple, only: %i[show edit update destroy]
  before_action :modify_params_create, only: %i[create]
  before_action :modify_params_update, only: %i[update]

  #TODO: add pagination and not just to this model!
  # GET /food_simples or /food_simples.json
  def index
    @food_simples = FoodSimple.where(
      '(user_id = ?) OR (public = TRUE)',
      current_user.id
    )
  end

  # GET /food_simples/1 or /food_simples/1.json
  def show
    unless helpers.food_simple_user_permission(@food_simple.id,
                                               current_user.id) >= FoodSimplesHelper::PERMISSION_READONLY
      respond_to do |format|
        @food_simple.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @food_simple.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /food_simples/new
  def new
    @food_simple = FoodSimple.new
  end

  # GET /food_simples/1/edit
  def edit
    unless helpers.food_simple_user_permission(@food_simple.id, current_user.id) >= FoodSimplesHelper::PERMISSION_EDIT
      respond_to do |format|
        @food_simple.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @food_simple.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /food_simples or /food_simples.json
  def create
    @food_simple = FoodSimple.new(food_simple_params)

    respond_to do |format|
      if @food_simple.save
        format.html { redirect_to food_simple_url(@food_simple), notice: 'Food simple was successfully created.' }
        format.json { render :show, status: :created, location: @food_simple }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food_simple.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_simples/1 or /food_simples/1.json
  def update
    if helpers.food_simple_user_permission(@food_simple.id, current_user.id) < FoodSimplesHelper::PERMISSION_EDIT
      respond_to do |format|
        @food_simple.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @food_simple.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @food_simple.update(food_simple_params)
          format.html { redirect_to food_simple_url(@food_simple), notice: 'Food simple was successfully updated.' }
          format.json { render :show, status: :ok, location: @food_simple }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @food_simple.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /food_simples/1 or /food_simples/1.json
  def destroy
    if helpers.food_simple_user_permission(@food_simple.id, current_user.id) < FoodSimplesHelper::PERMISSION_OWNERSHIP
      respond_to do |format|
        @food_simple.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @food_simple.errors, status: :unprocessable_entity }
      end
    else
      @food_simple.destroy

      respond_to do |format|
        format.html { redirect_to food_simples_url, notice: 'Food simple was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food_simple
    @food_simple = FoodSimple.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_simple_params
    params.require(:food_simple).permit(:name, :calories, :fats, :carbs, :proteins, :is_drink, :amount, :verified,
                                        :public, :description, :user_id)
  end

  # #TODO this should be changed so they can't manage everything,
  # only verify
  #TODO: what if creating for another user?
  # Modify to overwrite with current user id.
  def modify_params_create
    params[:food_simple][:user_id] = current_user.id
    params[:food_simple][:verified] = false if current_user.role == 'user'
  end

  # #TODO this should be changed so they can't manage everything,
  # only verify
  #TODO: what if creating for another user?
  # Modify to overwrite with current user id.
  # #TODO there should be a table where we keep record of which admin approved
  # which food, etc
  def modify_params_update
    if current_user.role == 'user'
      params[:food_simple][:user_id] = current_user.id
      params[:food_simple][:verified] = FoodSimple.find(params[:id]).verified
    else
      params[:food_simple][:user_id] = FoodSimple.find(params[:id]).user_id
    end
  end
end
