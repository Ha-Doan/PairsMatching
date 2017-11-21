class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.datetime :date
      t.text :pairs, array: true, default: []

      t.timestamps
    end
  end
end
