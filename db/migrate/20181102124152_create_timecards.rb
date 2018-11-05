class CreateTimecards < ActiveRecord::Migration[5.2]
  def change
    create_table :timecards do |t|
      t.integer :user_id
      t.datetime :startofwork
      t.datetime :endofwork

      t.timestamps
    end
  end
end
