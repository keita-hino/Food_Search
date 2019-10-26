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

end
