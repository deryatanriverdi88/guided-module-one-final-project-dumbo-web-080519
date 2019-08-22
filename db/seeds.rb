# clear existing seeded data
Group.destroy_all
Meetup.destroy_all
Membership.destroy_all
User.destroy_all
Rsvp.destroy_all


# query meetup api for group list
group_json = RestClient.get("http://api.meetup.com/find/groups%3F&sign=true&photo-host=public&location=brooklyn&page=20?access_token=14c80981edefcc4aa68dae85fb41b203")
group_array = JSON.parse(group_json)

# mass assign group data
group_array[0,50].each do |group|
  new_group = Group.create(
    title: group["name"],
    category: group["category"]["name"],
    description: (Nokogiri::HTML(group["description"]).content.split("<br>").join(""))
  )
  group_url = group["link"]
  group_url.slice!(group_url.length - 1)
  group_url.slice!("https://www.meetup.com/")
  meetup_json = RestClient.get("https://api.meetup.com/#{group_url}/events?access_token=14c80981edefcc4aa68dae85fb41b203&photo-host=public&page=5")
  meetup_array = JSON.parse(meetup_json)

  meetup_array.each do |meetup|
    if meetup["venue"]
      location = meetup["venue"]["name"]
    else
      location = "N/A"
    end
    Meetup.create(
      group_id: new_group.id,
      location: location,
      date: Time.parse(meetup["local_date"]),
      time: Time.parse(meetup["local_time"])
    )
  end
end


# https://api.meetup.com/#{group_url}/events?key=26104d552b227291f633d6c7f2b4f13&sign=true&photo-host=public&page=5

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
