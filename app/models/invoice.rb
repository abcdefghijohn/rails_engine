class Invoice < ApplicationRecord
  belongs_to :customer, dependent: :destroy
  belongs_to :merchant, dependent: :destroy
end
