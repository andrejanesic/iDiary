module FoodComplexesHelper
  PERMISSION_NOPERMISSION = 0
  PERMISSION_READONLY = 1
  PERMISSION_EDIT = 2
  PERMISSION_OWNERSHIP = 3
  # PERMISSION_OWNERSHIP = 4 #TODO if owner, can share
  def food_complex_user_permission(fc_id, u_id)
    # #TODO this should be changed so they can't manage everything,
    # only verify
    return FoodComplexesHelper::PERMISSION_OWNERSHIP if User.find(u_id).role == 'admin'

    return FoodComplexesHelper::PERMISSION_READONLY if FoodComplex.find(fc_id).public

    # if actual owner
    if FoodComplex.find(fc_id).user_id == u_id
      FoodComplexesHelper::PERMISSION_OWNERSHIP
    else
      PERMISSION_NOPERMISSION
    end
    # TODO: sharing for food_complexes
    # if not owner, check if shared
    #     food_complex_shares = FoodComplexShare.where(food_complex_id: fc_id, user_id: u_id)
    #     if food_complex_shares.empty?
    #       FoodComplexesHelper::PERMISSION_NOPERMISSION
    #     else
    #       food_complex_shares[0].permission
    #     end
    #   end
  rescue StandardError => e
    FoodComplexesHelper::PERMISSION_NOPERMISSION
  end
end
