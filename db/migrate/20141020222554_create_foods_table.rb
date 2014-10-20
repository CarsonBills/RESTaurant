class CreateFoodsTable < ActiveRecord::Migration
  def change
  	create_table :foods do |t|
  		t.integer :price
  		t.string :name

  		t.timestamps
  	end
  end
end
