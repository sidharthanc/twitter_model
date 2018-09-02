class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.integer :user_id
      t.integer :post_id
      t.timestamps
    end
    add_foreign_key :retweets, :users, column: :user_id
    add_foreign_key :retweets, :posts, column: :post_id
  end
end
