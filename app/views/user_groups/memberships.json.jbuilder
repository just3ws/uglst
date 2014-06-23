# @people = People.all
json.array! @ugms do |ugm|
  json.name ugm.user.profile.full_name_or_username
end
