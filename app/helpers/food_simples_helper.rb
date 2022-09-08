module FoodSimplesHelper
  PERMISSION_NOPERMISSION = 0
  PERMISSION_READONLY = 1
  PERMISSION_EDIT = 2
  PERMISSION_OWNERSHIP = 3
  # PERMISSION_OWNERSHIP = 4 #TODO if owner, can share
  def food_simple_user_permission(fs_id, u_id)
    # #TODO this should be changed so they can't manage everything,
    # only verify
    if User.find(u_id).role == 'admin'
      FoodSimplesHelper::PERMISSION_OWNERSHIP
    elsif FoodSimple.find(fs_id).verified
      # if verified and not admin
      FoodSimplesHelper::PERMISSION_READONLY
    elsif FoodSimple.find(fs_id).user_id == u_id
      # if actual owner
      FoodSimplesHelper::PERMISSION_OWNERSHIP
    else
      return FoodSimplesHelper::PERMISSION_READONLY if FoodSimple.find(fs_id).public

      PERMISSION_NOPERMISSION

      # TODO: sharing for food_simples
      # if not owner, check if shared
      #     food_simple_shares = FoodSimpleShare.where(food_simple_id: fs_id, user_id: u_id)
      #     if food_simple_shares.empty?
      #       FoodSimplesHelper::PERMISSION_NOPERMISSION
      #     else
      #       food_simple_shares[0].permission
      #     end
      #   end
    end
  rescue StandardError => e
    FoodSimplesHelper::PERMISSION_NOPERMISSION
  end
end
