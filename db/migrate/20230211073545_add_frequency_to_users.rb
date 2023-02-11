class AddFrequencyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :frequency, :string
    add_column :users, :distance, :string
  end
end
