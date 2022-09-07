module FoodSimplesHelper
  PERMISSION_NOPERMISSION = 0
  PERMISSION_READONLY = 1
  PERMISSION_EDIT = 2
  PERMISSION_OWNERSHIP = 3
  # PERMISSION_OWNERSHIP = 4 #TODO if owner, can share
  def food_simple_user_permission(fs_id, u_id)
    # #TODO this should be changed so they can't manage everything,
    # only verify
    return FoodSimplesHelper::PERMISSION_OWNERSHIP if User.find(u_id).role == 'admin'

    return FoodSimplesHelper::PERMISSION_READONLY if FoodSimple.find(fs_id).public

    # if actual owner
    if FoodSimple.find(fs_id).user_id == u_id
      FoodSimplesHelper::PERMISSION_OWNERSHIP
    else
      PERMISSION_NOPERMISSION
    end
    # TODO: sharing for food_simples
    # if not owner, check if shared
    #     food_simple_shares = FoodSimpleShare.where(food_simple_id: fs_id, user_id: u_id)
    #     if food_simple_shares.empty?
    #       FoodSimplesHelper::PERMISSION_NOPERMISSION
    #     else
    #       food_simple_shares[0].permission
    #     end
    #   end
  rescue StandardError => e
    FoodSimplesHelper::PERMISSION_NOPERMISSION
  end
end
