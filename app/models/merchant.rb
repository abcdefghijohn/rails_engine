# frozen_string_literal: true

class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices

  def self.most_revenue(quantity)
    Merchant.joins(invoices: %i[transactions invoice_items])
    .where(transactions: { result: 'success'})
    .where(invoices: { status: 'shipped'})
    .group(:id)
    .select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue")
    .order('revenue DESC')
    .limit(quantity)
  end

  def self.most_items(quantity)
    Merchant.joins(invoices: %i[transactions invoice_items])
    .where(transactions: { result: 'success'})
    .where(invoices: { status: 'shipped'})
    .group(:id)
    .select("merchants.*, sum(invoice_items.quantity) as total_sold")
    .order('total_sold DESC')
    .limit(quantity)
  end
end
