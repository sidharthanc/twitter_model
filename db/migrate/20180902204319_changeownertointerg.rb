class Changeownertointerg < ActiveRecord::Migration
  def change
  	change_column :follows, :owner, 'integer USING CAST(owner AS integer)'
  end
end
