class Restaurant < ApplicationRecord
  # 論理削除用
  acts_as_paranoid

  ####################################
  # リレーション
  ####################################
  # belongs_to :user, option: true

  ####################################
  # スコープ
  ####################################
  scope :user_id_is, -> (user_id) { where(user_id:user_id) }

end
