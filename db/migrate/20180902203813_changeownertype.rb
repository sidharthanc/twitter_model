class Changeownertype < ActiveRecord::Migration
  def change
  	change_column :follows, :owner, 'integer USING CAST(column_name AS integer)'
  end
end
