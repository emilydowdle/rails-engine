require 'csv'

desc "Imports a Customers CSV file into an ActiveRecord table"
task :import, [:customers_csv] => :environment do
  CSV.foreach('lib/assets/customers.csv', :headers => true) do |row|
    Customer.create!(row.to_hash)
  end
end

desc "Imports a Merchants CSV file into an ActiveRecord table"
task :import, [:merchants_csv] => :environment do
  CSV.foreach('lib/assets/merchants.csv', :headers => true) do |row|
    Merchant.create!(row.to_hash)
  end
end

desc "Imports a Item CSV file into an ActiveRecord table"
task :import, [:items_csv] => :environment do
  CSV.foreach('lib/assets/items.csv', :headers => true) do |row|
    Item.create!(row.to_hash)
  end
end

desc "Imports a Invoice CSV file into an ActiveRecord table"
task :import, [:invoices_csv] => :environment do
  CSV.foreach('lib/assets/invoices.csv', :headers => true) do |row|
    Invoice.create!(row.to_hash)
  end
end

desc "Imports a Transaction CSV file into an ActiveRecord table"
task :import => :environment do
  CSV.foreach('lib/assets/transactions.csv', :headers => true) do |row|
    Transaction.create!(
                        invoice_id: row.field("invoice_id"),
                        credit_card_number: row.field("credit_card_number"),
                        result: row.field("result"),
                        created_at: row.field("created_at"),
                        updated_at: row.field("updated_at")
                        )
  end
end

desc "Imports a Invoice Item CSV file into an ActiveRecord table"
task :import, [:invoice_items_csv] => :environment do
  CSV.foreach('lib/assets/invoice_items.csv', :headers => true) do |row|
    InvoiceItem.create!(row.to_hash)
  end
end
