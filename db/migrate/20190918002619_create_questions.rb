# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :body, null: false
      t.text :slug, null: false, unique: true
      t.text :url, null: false, unique: true
      t.boolean :crawled, default: false, null: false
      t.integer :related_question_ids, array: true

      t.timestamps
    end
  end
end
