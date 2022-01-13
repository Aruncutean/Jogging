class CreateUserTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_times do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :time
      t.string :distance
      t.string :speed
      t.datetime :date

      t.timestamps
    end
  end
end
