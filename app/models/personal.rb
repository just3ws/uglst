class Personal < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }

  belongs_to :user, inverse_of: :personal

  crypt_keeper :parental_status,
               :birthday,
               :ethnicity,
               :gender,
               :race,
               :relationship_status,
               :religious_affiliation,
               :sexual_orientation,
               encryptor:        :postgres_pgp,
               key:              ENV['CRYPT_KEEPER_KEY'],
               pgcrypto_options: 'compress-level=9',
               encoding:         'UTF-8'
end

# == Schema Information
# Schema version: 20140616040112
#
# Table name: personals
#
#  id                    :uuid             not null, primary key
#  user_id               :uuid
#  birthday              :text
#  ethnicity             :text
#  gender                :text
#  parental_status       :text
#  race                  :text
#  relationship_status   :text
#  religious_affiliation :text
#  sexual_orientation    :text
#  created_at            :datetime         indexed
#  updated_at            :datetime
#
# Indexes
#
#  index_personals_on_created_at  (created_at)
#
