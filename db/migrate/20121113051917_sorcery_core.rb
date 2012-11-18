class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email,            :null => false 
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.string :remember_me_token, :default => nil
      t.datetime :remember_me_token_expires_at, :default => nil
      t.integer :village_id
      
      t.timestamps
    end
    add_index :users, :remember_me_token
  end

  def self.down
    drop_table :users
  end
end