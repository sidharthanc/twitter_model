class Changecoloumnownertype < ActiveRecord::Migration
  def change
  change_column :follows, :owner, :integer
end
end
