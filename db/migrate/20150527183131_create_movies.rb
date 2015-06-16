class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :director
      t.text :description
      t.integer :year
      t.decimal :length #, :scale => 10, :precision => 2
      t.string :format

      t.timestamps null: false
    end
  end
end
