class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email,         :null => false
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.string :head_title
      t.string :tail_title
      t.string :mobile
      t.string :gender
      t.datetime :birth
      t.integer :book_count
      t.integer :deal_count

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end