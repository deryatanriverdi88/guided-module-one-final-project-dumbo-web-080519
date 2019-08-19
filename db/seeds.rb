# clear existing seeded data
Group.destroy_all
Meetup.destroy_all
Membership.destroy_all
User.destroy_all
Rsvp.destroy_all


# query meetup api for group list
group_json = RestClient.get("http://api.meetup.com/find/groups%3F&sign=true&photo-host=public&location=brooklyn&page=20?key=26104d552b227291f633d6c7f2b4f13&group_urlname=ny-tech&sign=true")
group_array = JSON.parse(group_json)

# mass assign group data
group_array.each do |group|
  Group.create(
    title: group["name"],
    category: group["category"]["name"],
    description: Nokogiri::HTML(group["description"]).content
  )
end

User.create(
  name: "Derya",
  location: "Brooklyn",
  age: 31
)

User.create(
  name: "Sukrit",
  location: "Queens",
  age: 25
)
