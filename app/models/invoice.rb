# frozen_string_literal: true

class Invoice < ApplicationRecord
  validates :customer_id, :merchant_id, :status, presence: true

  belongs_to :customer
  belongs_to :merchant

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  # def self.most_expensive
  #   Invoice.select("invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
  #     .joins(:invoice_items, :transactions)
  #     # .where(transactions: {results: "success"})
  #     .merge(Transaction.successful)
  #     .group(:id)
  #     .order("revenue DESC")
  #     .limit(5)
  # end
end



# Find the 5 most expensive invoices with successful transactions
#
# Tables
# invoices: invoice* status(shipped)
# transactions: invoice_id, result(success)
# invoice_items: invoice_id, quantity, unit_price
# first join invoices to invoice_items
#
# Invoice.select("invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
#   .joins(:invoice_items, :transactions)
#   .where(transactions: {results: "success"})
#   .group(:id)
#   .order("revenue DESC")
#   .limit(5)
# Invoice.select("invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).where("transaction.result=?" "success").group(:id).order("revenue DESC").limit(5)
