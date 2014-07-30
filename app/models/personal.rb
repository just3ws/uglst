class Personal < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }

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

  belongs_to :user, inverse_of: :personal
end

# == Schema Information
# Schema version: 20140726033553
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
#  created_at            :datetime
#  updated_at            :datetime
#
