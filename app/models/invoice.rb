# frozen_string_literal: true

class Invoice < ApplicationRecord
  validates :customer_id, :merchant_id, :status, presence: true

  belongs_to :customer
  belongs_to :merchant

  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy

  def self.revenue_dates(start_date, end_date)
    Invoice.joins(:transactions, :invoice_items)
           .select('sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
           .where(invoices: { status: 'shipped' })
           .where(transactions: { result: 'success' })
           .where('invoices.created_at >= ?', start_date.to_s)
           .where('invoices.created_at <= ?', end_date.to_s)
  end
end
