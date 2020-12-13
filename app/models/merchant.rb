class Merchant < ApplicationRecord
  validates :name, :created_at, :updated_at, presence: true

  has_many :items
  has_many :invoices
end
