class User < ApplicationRecord
  has_secure_password

  has_one :employee, dependent: :destroy
  has_many :bills, dependent: :destroy

  enum :role, { employee: 0, admin: 1 }

  normalizes :email, with: ->(email) { email.strip.downcase }

  before_validation :set_default_password, on: :create

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_default_password
    return if password.present?
    self.password = "Think@123"
    self.password_confirmation = "Think@123"
  end
end
