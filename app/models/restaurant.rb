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
  scope :user_uid_is, -> (value) {
     where(user_id: value) 
  }

end
