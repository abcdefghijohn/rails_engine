# frozen_string_literal: true

class Item < ApplicationRecord
  validates :name, :description, :unit_price, :merchant_id, presence: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
end
