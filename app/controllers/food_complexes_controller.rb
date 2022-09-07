class FoodComplexesController < ApplicationController
  layout 'app'
  before_action :authenticate_user!
  before_action :set_food_complex, only: %i[show edit update destroy]
  before_action :modify_params_create, only: %i[create]
  before_action :modify_params_update, only: %i[update]

  #TODO: add pagination and not just to this model!
  # GET /food_complexes or /food_complexes.json
  def index
    @food_complexes = FoodComplex.where(
      '(user_id = ?) OR (public = TRUE)',
      current_user.id
    )
  end

  # GET /food_complexes/1 or /food_complexes/1.json
  def show
    unless helpers.food_complex_user_permission(@food_complex.id,
                                               current_user.id) >= FoodComplexesHelper::PERMISSION_READONLY
      respond_to do |format|
        @food_complex.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @food_complex.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /food_complexes/new
  def new
    @food_complex = FoodComplex.new
  end

  # GET /food_complexes/1/edit
  def edit
    unless helpers.food_complex_user_permission(@food_complex.id, current_user.id) >= FoodComplexesHelper::PERMISSION_EDIT
      respond_to do |format|
        @food_complex.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @food_complex.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /food_complexes or /food_complexes.json
  def create
    @food_complex = FoodComplex.new(food_complex_params)

    respond_to do |format|
      if @food_complex.save
        format.html { redirect_to food_complex_url(@food_complex), notice: 'Food complex was successfully created.' }
        format.json { render :show, status: :created, location: @food_complex }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food_complex.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_complexes/1 or /food_complexes/1.json
  def update
    if helpers.food_complex_user_permission(@food_complex.id, current_user.id) < FoodComplexesHelper::PERMISSION_EDIT
      respond_to do |format|
        @food_complex.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @food_complex.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        if @food_complex.update(food_complex_params)
          format.html { redirect_to food_complex_url(@food_complex), notice: 'Food complex was successfully updated.' }
          format.json { render :show, status: :ok, location: @food_complex }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @food_complex.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /food_complexes/1 or /food_complexes/1.json
  def destroy
    if helpers.food_complex_user_permission(@food_complex.id, current_user.id) < FoodComplexesHelper::PERMISSION_OWNERSHIP
      respond_to do |format|
        @food_complex.errors.add(:diary, 'is not shared with you.')
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @food_complex.errors, status: :unprocessable_entity }
      end
    else
      @food_complex.destroy

      respond_to do |format|
        format.html { redirect_to food_complexes_url, notice: 'Food complex was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food_complex
    @food_complex = FoodComplex.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_complex_params
    params.require(:food_complex).permit(:name, :description, :template, :verified, :public, :user_id)
  end

  # #TODO this should be changed so they can't manage everything,
  # only verify
  #TODO: what if creating for another user?
  # Modify to overwrite with current user id.
  def modify_params_create
    params[:food_complex][:user_id] = current_user.id
    params[:food_complex][:verified] = false if current_user.role == 'user'
  end

  # #TODO this should be changed so they can't manage everything,
  # only verify
  #TODO: what if creating for another user?
  # Modify to overwrite with current user id.
  # #TODO there should be a table where we keep record of which admin approved
  # which food, etc
  def modify_params_update
    if current_user.role == 'user'
      params[:food_complex][:user_id] = current_user.id
      params[:food_complex][:verified] = FoodComplex.find(params[:id]).verified
    else
      params[:food_complex][:user_id] = FoodComplex.find(params[:id]).user_id
    end
  end
end
