class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :body
      t.integer :create_by
      t.integer :send_to
      t.timestamps
    end
  end
end
