# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :description, null: false
      t.integer :state, default: 0, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tasks,[:user_id, :state]
  end
end
