class AddRequestCountToTenants < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :request_count, :integer, :default => 0
  end
end
