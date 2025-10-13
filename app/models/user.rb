class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  # TEACHER ASSOCIATION: Resources created by the user
  has_many :resources, dependent: :destroy 

  # STUDENT ASSOCIATIONS: Resources saved by the user
  # 1. The join table (The saved_resources method used in the controller)
  has_many :saved_resources, dependent: :destroy
  
  # 2. The actual resource objects (The saved_items method used in the browse view)
  has_many :saved_items, through: :saved_resources, source: :resource
end
