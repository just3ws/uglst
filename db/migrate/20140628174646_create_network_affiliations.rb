# frozen_string_literal: true
class CreateNetworkAffiliations < ActiveRecord::Migration
  def change
    create_table(:network_affiliations, id: :uuid) do |t|
      t.uuid :network_id
      t.uuid :user_group_id

      t.timestamps
    end
    add_index :network_affiliations, :network_id
    add_index :network_affiliations, :user_group_id
    add_index :network_affiliations, %i(network_id user_group_id)
  end
end
