class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :connections, dependent: :destroy
  has_many :accounts

  after_commit :create_customer, on: :create

  def create_customer
    CreateCustomerJob.perform_later(self)
  end
end
