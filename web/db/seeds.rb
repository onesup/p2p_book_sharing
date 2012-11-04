# coding : utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Village.create(
  [
    {
      si: "서울시",
      dong: "광진구",
      gu: "자양동",
      village: "우성아파트"
    },
    {
      si: "서울시",
      dong: "관악구",
      gu: "난향동",
      village: "관악산휴먼시아"
    }
  ]
)
users = User.create(
  [
    { 
      email: 'wasabi@moncl.net',
      username: "완쌉",
      password: "1111"
     },
     { 
       email: 'ceo@moncl.net',
       username: "빵진",
       password: "1111"
      }     
  ]
)

wasabi = User.first.village = Village.first
wasabi.save
ceo = User.last.village = Village.last
ceo.save

puts users.first.email
puts users.last.email



