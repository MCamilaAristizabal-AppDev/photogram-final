class CreateFollowrequests < ActiveRecord::Migration[6.0]
  def change
    create_table :followrequests do |t|
      t.string :status
      t.integer :recepient_id
      t.integer :sender_id

      t.timestamps
    end
  end
end
