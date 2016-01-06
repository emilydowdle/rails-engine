class AddInvoiceToTransaction < ActiveRecord::Migration
  def change
    add_reference :transactions, :invoice, index: true, foreign_key: true
  end
end
