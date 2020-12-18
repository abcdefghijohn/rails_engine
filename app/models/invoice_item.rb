# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  validates :item_id, :invoice_id, :quantity, :unit_price, presence: true

  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoices, dependent: :destroy
end
