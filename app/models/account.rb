class Account < ApplicationRecord
  belongs_to :user
  belongs_to :connection
  has_many :transactions, dependent: :delete_all
end
