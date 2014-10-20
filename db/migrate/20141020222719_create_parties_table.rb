class CreatePartiesTable < ActiveRecord::Migration
  def change
  	create_table :parties do |t|
  		t.string :name
  		t.integer :size
  		t.boolean :paid, :default => false
  		t.timestamps
  	end
  end
end
