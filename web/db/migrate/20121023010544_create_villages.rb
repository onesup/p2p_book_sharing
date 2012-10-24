class CreateVillages < ActiveRecord::Migration
  def change
    create_table :villages do |t|
      t.string :code
      t.string :si
      t.string :gu
      t.string :dong
      t.string :village

      t.timestamps
    end
  end
end
