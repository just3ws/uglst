class Personal < ActiveRecord::Base
  belongs_to :user

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
