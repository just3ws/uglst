class CreatePersonals < ActiveRecord::Migration
  def change
    # http://www.whitehouse.gov/omb/fedreg_1997standards
    #
    # The goal is to be able to identify whether people
    # of various demographics are being represented in
    # user-group communities.
    #
    # Are parents being represented? POC? Sexual Orientation? Etc.
    #
    # What variety of combinations of people's can be found across the global community?
    create_table(:personals, id: :uuid) do |t|
      t.references :user, index: true

      t.text :birthday
      t.text :ethnicity
      t.text :gender
      t.text :parental_status
      t.text :race
      t.text :relationship_status
      t.text :religious_affiliation
      t.text :sexual_orientation

      t.timestamps
    end
  end
end
