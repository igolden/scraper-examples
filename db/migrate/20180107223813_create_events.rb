class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :date
      t.string :day
      t.string :month
      t.string :time
      t.string :title
      t.string :host
      t.string :categories
    end
  end
end
