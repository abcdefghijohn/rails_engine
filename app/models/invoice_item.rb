class InvoiceItem < ApplicationRecord
  validates :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, presence: true

  belongs_to :item
  belongs_to :invoice
end
