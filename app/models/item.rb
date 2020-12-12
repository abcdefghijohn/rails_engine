class Item < ApplicationRecord
  belongs_to :merchant, dependent: :destroy
end
