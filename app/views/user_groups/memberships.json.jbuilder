# @people = People.all
json.array! @ugms do |ugm|
  json.name ugm.user.profile.preferred_name_or_username
end
