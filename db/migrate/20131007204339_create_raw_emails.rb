class CreateRawEmails < ActiveRecord::Migration
  def up
    create_table :raw_emails do |t|
      t.string  :redis_key
      t.text    :source
      t.integer :microtime
      t.timestamps
    end
  end

  def down
    drop_table :raw_emails
  end
end
