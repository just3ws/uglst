RSpec.describe Personal, type: :model do
end

# == Schema Information
# Schema version: 20140622214224
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
