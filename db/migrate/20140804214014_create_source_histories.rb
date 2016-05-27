# frozen_string_literal: true
class CreateSourceHistories < ActiveRecord::Migration
  def change
    create_table(:source_histories, id: :uuid) do |t|
      t.uuid :source_id
      t.uuid :user_group_id
      t.string :remote_identifier

      t.timestamps
    end

    add_index :source_histories, :source_id
    add_index :source_histories, :user_group_id
    add_index :source_histories, %i(source_id user_group_id)
  end
end
