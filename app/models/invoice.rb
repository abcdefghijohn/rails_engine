class Invoice < ApplicationRecord
  validates :customer_id, :merchant_id, :status, presence: true

  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :items, through: :invoice_items

end
