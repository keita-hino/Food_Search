class Restaurant < ApplicationRecord
  # 論理削除用
  acts_as_paranoid

  ####################################
  # Associations
  ####################################
  # belongs_to :user, option: true

  ####################################
  # Scopes
  ####################################

  scope :user_uid_is, -> (value) {
     where(user_id: value)
  }

  ####################################
  # Validates
  ####################################

  validates :name,
    presence: true

  validates :address,
    presence: true

  validates :open_info,
    presence: true

  ####################################
  # Methods
  ####################################

# 住所length以上の文字数の場合、length数以内に縮小した文字列返却（lengthの初期値が31なのは、カードの幅を考慮しているため）
  def short_address(length = 28)
    self.address.length >= length ? self.address[0, length] + '...' : ''
  end

  # 営業時間がlength以上の文字数の場合、length数以内に縮小した文字列返却（lengthの初期値が31なのは、カードの幅を考慮しているため）
  def short_open_info(length = 28)
    self.open_info.length >= length ? self.open_info[0, length] + '...' : ''
  end

end
