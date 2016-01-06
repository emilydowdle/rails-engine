class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.datetime :credit_card_expiration_date
      t.string :result

      t.timestamps null: false
    end
  end
end
