# frozen_string_literal: true
class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics, id: :uuid do |t|
      t.string :session_id

      t.string :request_action
      t.string :request_controller
      t.string :request_ip
      t.string :request_method
      t.string :request_referrer
      t.string :request_requestor_ip
      t.string :request_url
      t.string :request_user_agent
      t.string :request_xff

      t.uuid :user_id

      t.json :request_params

      t.timestamps null: false
    end
  end
end
