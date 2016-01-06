Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants#find', defaults: { format: :json }
      get 'merchants/find_all', to: 'merchants#find_all', defaults: { format: :json }
      get 'merchants/random', to: 'merchants#random', defaults: { format: :json }
      get 'merchants/:id/invoices', to: 'merchants#invoices', defaults: { format: :json }
      get 'merchants/:id/items', to: 'merchants#items', defaults: { format: :json }
      get 'merchants/most_revenue', to: 'merchants#most_revenue', defaults: { format: :json }
      get 'merchants/revenue', to: 'merchants#revenue_by_date', defaults: { format: :json }
      get 'merchants/:id/revenue', to: 'merchants#revenue', defaults: { format: :json }
      get 'merchants/:id/favorite_customer', to: 'merchants#favorite_customer', defaults: { format: :json }
      get 'merchants/:id/customers_with_pending_invoices', to: 'merchants#customers_with_pending_invoices', defaults: { format: :json }

      resources :merchants, only: [:index, :show], defaults: { format: :json }

      get 'customers/find', to: 'customers#find', defaults: { format: :json }
      get 'customers/find_all', to: 'customers#find_all', defaults: { format: :json }
      get 'customers/random', to: 'customers#random', defaults: { format: :json }
      get 'customers/:id/invoices', to: 'customers#invoices', defaults: { format: :json }
      get 'customers/:id/transactions', to: 'customers#transactions', defaults: { format: :json }
      get 'customers/:id/favorite_merchant', to: 'customers#favorite_merchant', defaults: { format: :json }
      resources :customers, only: [:index, :show], defaults: { format: :json }

      get 'invoice_items/find', to: 'invoice_items#find', defaults: { format: :json }
      get 'invoice_items/find_all', to: 'invoice_items#find_all', defaults: { format: :json }
      get 'invoice_items/random', to: 'invoice_items#random', defaults: { format: :json }
      get 'invoice_items/:id/item', to: 'invoice_items#item', defaults: { format: :json }
      get 'invoice_items/:id/invoice', to: 'invoice_items#invoice', defaults: { format: :json }
      resources :invoice_items, only: [:index, :show], defaults: { format: :json }

      get 'invoices/find', to: 'invoices#find', defaults: { format: :json }
      get 'invoices/find_all', to: 'invoices#find_all', defaults: { format: :json }
      get 'invoices/random', to: 'invoices#random', defaults: { format: :json }
      get 'invoices/:id/transactions', to: 'invoices#transactions', defaults: { format: :json }
      get 'invoices/:id/invoice_items', to: 'invoices#invoice_items', defaults: { format: :json }
      get 'invoices/:id/items', to: 'invoices#items', defaults: { format: :json }
      get 'invoices/:id/customer', to: 'invoices#customer', defaults: { format: :json }
      get 'invoices/:id/merchant', to: 'invoices#merchant', defaults: { format: :json }
      resources :invoices, only: [:index, :show], defaults: { format: :json }

      get 'items/find', to: 'items#find', defaults: { format: :json }
      get 'items/find_all', to: 'items#find_all', defaults: { format: :json }
      get 'items/random', to: 'items#random', defaults: { format: :json }
      get 'items/:id/invoice_items', to: 'items#invoice_items', defaults: { format: :json }
      get 'items/:id/merchant', to: 'items#merchant', defaults: { format: :json }
      get 'items/:id/best_day', to: 'items#best_day', defaults: { format: :json }
      resources :items, only: [:index, :show], defaults: { format: :json }

      get 'transactions/find', to: 'transactions#find', defaults: { format: :json }
      get 'transactions/find_all', to: 'transactions#find_all', defaults: { format: :json }
      get 'transactions/random', to: 'transactions#random', defaults: { format: :json }
      get 'transactions/:id/invoice', to: 'transactions#invoice', defaults: { format: :json }
      resources :transactions, only: [:index, :show], defaults: { format: :json }
    end
  end
end
