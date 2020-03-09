class CreateApiClients < ActiveRecord::Migration[6.0]
  def change
    create_table :api_clients do |t|
      t.string :name, index: { unique: true }
      t.string :key

      t.timestamps
    end
  end
end
