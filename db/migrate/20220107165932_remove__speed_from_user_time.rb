class RemoveSpeedFromUserTime < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_times, :speed
  end
end
