module DiariesHelper
  PERMISSION_NOPERMISSION = 0
  PERMISSION_READONLY = 1
  PERMISSION_EDIT = 2
  PERMISSION_OWNERSHIP = 3
  # PERMISSION_OWNERSHIP = 4 #TODO if owner, can share
  def diary_user_permission(d_id, u_id)
    # if actual owner
    if Diary.find(d_id).user_id == u_id
      DiariesHelper::PERMISSION_OWNERSHIP
    else
      # if not owner, check if shared
      diary_shares = DiaryShare.where(diary_id: d_id, user_id: u_id)
      if diary_shares.empty?
        DiariesHelper::PERMISSION_NOPERMISSION
      else
        diary_shares[0].permission
      end
    end
  rescue StandardError => e
    DiariesHelper::PERMISSION_NOPERMISSION
  end
end
