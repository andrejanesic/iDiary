module GoalsHelper
  PERMISSION_NOPERMISSION = 0
  PERMISSION_READONLY = 1
  PERMISSION_EDIT = 2
  PERMISSION_OWNERSHIP = 3
  # PERMISSION_OWNERSHIP = 4 #TODO if owner, can share
  def goal_user_permission(g_id, u_id)
    # if actual owner
    if Goal.find(g_id).user_id == u_id
      GoalsHelper::PERMISSION_OWNERSHIP
    else
      PERMISSION_NOPERMISSION
    end
  # TODO: sharing for goals
  # if not owner, check if shared
  #     goal_shares = GoalShare.where(goal_id: g_id, user_id: u_id)
  #     if goal_shares.empty?
  #       GoalsHelper::PERMISSION_NOPERMISSION
  #     else
  #       goal_shares[0].permission
  #     end
  #   end
  rescue StandardError => e
    GoalsHelper::PERMISSION_NOPERMISSION
  end
end
