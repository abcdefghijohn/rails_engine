require 'csv'

# InvoiceItem.destroy_all
# Item.destroy_all
# Transaction.destroy_all
# Invoice.destroy_all
# Customer.destroy_all
# Merchant.destroy_all

cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)


data = 'db/data/items.csv'
CSV.foreach(Rails.root.join(data), headers:true) do |row|
  row['unit_price'] = (row['unit_price'].to_f / 100).round(2)
  Item.create!(row.to_hash)
end

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
