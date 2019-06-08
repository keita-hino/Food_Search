class Restaurant < ApplicationRecord
  # 論理削除用
  acts_as_paranoid

end
