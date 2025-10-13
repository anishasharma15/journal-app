class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  # Existing: A User (Teacher) has many resources they created
  has_many :resources, dependent: :destroy 

  # --- Saved Resources Associations (Student's saved resources) ---
  # 1. The join table (SavedResource objects)
  has_many :saved_resources, dependent: :destroy
  
  # 2. The actual resource objects retrieved through the join table
  # This creates the 'current_user.saved_items' method, used in StudentaccountController.
  has_many :saved_items, through: :saved_resources, source: :resource
end