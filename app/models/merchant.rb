class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices

end
