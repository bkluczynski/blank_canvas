class CreateSketches < ActiveRecord::Migration
  def change
    create_table :sketches do |t|

      t.timestamps null: false
    end
  end
end
