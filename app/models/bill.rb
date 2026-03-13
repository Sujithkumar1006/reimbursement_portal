class Bill < ApplicationRecord
  belongs_to :user
  enum :bill_type, { food: 0, travel: 1, others: 2 }
  enum :status, { approved: 0, pending: 1, rejected: 2 }
end
