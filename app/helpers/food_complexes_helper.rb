module FoodComplexesHelper
  PERMISSION_NOPERMISSION = 0
  PERMISSION_READONLY = 1
  PERMISSION_EDIT = 2
  PERMISSION_OWNERSHIP = 3
  # PERMISSION_OWNERSHIP = 4 #TODO if owner, can share
  def food_complex_user_permission(fc_id, u_id)
    # #TODO this should be changed so they can't manage everything,
    # only verify
    if User.find(u_id).role == 'admin'
      FoodComplexesHelper::PERMISSION_OWNERSHIP
    elsif FoodComplex.find(fc_id).verified
      # if verified and not admin
      FoodComplexesHelper::PERMISSION_READONLY
    elsif FoodComplex.find(fc_id).user_id == u_id
      # if actual owner
      FoodComplexesHelper::PERMISSION_OWNERSHIP
    else
      return FoodComplexesHelper::PERMISSION_READONLY if FoodComplex.find(fc_id).public

      PERMISSION_NOPERMISSION

      # TODO: sharing for food_complexes
      # if not owner, check if shared
      #     food_complex_shares = FoodComplexShare.where(food_complex_id: fc_id, user_id: u_id)
      #     if food_complex_shares.empty?
      #       FoodComplexesHelper::PERMISSION_NOPERMISSION
      #     else
      #       food_complex_shares[0].permission
      #     end
      #   end
    end
  rescue StandardError => e
    FoodComplexesHelper::PERMISSION_NOPERMISSION
  end
end
