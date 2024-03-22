def load_test_data 
  def movies_full_data
    [
      {
          "adult": false,
          "backdrop_path": "/8lBcqakI3F19NWkXdqE0M8W76b9.jpg",
          "genre_ids": [
              28,
              18,
              36,
              10752
          ],
          "id": 197,
          "original_language": "en",
          "original_title": "Braveheart",
          "overview": "Enraged at the slaughter of Murron, his new bride and childhood love, Scottish warrior William Wallace slays a platoon of the local English lord's soldiers. This leads the village to revolt and, eventually, the entire country to rise up against English rule.",
          "popularity": 61.462,
          "poster_path": "/or1gBugydmjToAEq7OZY0owwFk.jpg",
          "release_date": "1995-05-24",
          "title": "Braveheart",
          "video": false,
          "vote_average": 7.94,
          "vote_count": 9670
      },
      {
          "adult": false,
          "backdrop_path": "/42l0U9K3pgIPzwtc4m0FJICijW8.jpg",
          "genre_ids": [
              37
          ],
          "id": 448394,
          "original_language": "en",
          "original_title": "Braveheart",
          "overview": "Chief Standing Rock's tribe has a treaty protecting their fishing grounds, but a canning corporation is violating the treaty through intimidation and force. The tribe is divided as to how to handle the threat. Standing Rock's son, Braveheart, is sent to college to study law so that he can protect their rights, but others in the tribe, led by the hot-tempered Ki-Yote, want to provoke a more violent confrontation.",
          "popularity": 1.949,
          "poster_path": "/vNUIfAXXPsF8tvHnnml5lLRJyAn.jpg",
          "release_date": "1925-12-27",
          "title": "Braveheart",
          "video": false,
          "vote_average": 0.0,
          "vote_count": 0
      }
    ]
  end

  def movies_show_data(movie_id)
    facade = MovieFacade.new
    facade.aggregate_movie_show_data(movie_id)
  end

  # create Users
  10.times do |n|
    User.create!(id: n+1, name: Faker::Name.name, email: Faker::Internet.email)
  end

  # create Parties
  5.times do 
    ViewingParty.create!(duration: rand(0..240), date: Faker::Date.forward(days: rand(1..14)), start_time: Time.new.strftime("%H:%M"))
  end

  # set Hosts 
  UserParty.create!(viewing_party: ViewingParty.first, user: User.first, host: true)
  UserParty.create!(viewing_party: ViewingParty.second, user: User.second, host: true)
  UserParty.create!(viewing_party: ViewingParty.third, user: User.third, host: true)
  UserParty.create!(viewing_party: ViewingParty.fourth, user: User.fourth, host: true)
  UserParty.create!(viewing_party: ViewingParty.last, user: User.fifth, host: true)

  # set invites
  UserParty.create!(viewing_party: ViewingParty.first, user: User.second, host: false)
  UserParty.create!(viewing_party: ViewingParty.first, user: User.third, host: false)
  UserParty.create!(viewing_party: ViewingParty.second, user: User.fourth, host: false)
  UserParty.create!(viewing_party: ViewingParty.second, user: User.fourth, host: false)
  UserParty.create!(viewing_party: ViewingParty.last, user: User.second, host: false)
  UserParty.create!(viewing_party: ViewingParty.last, user: User.first, host: false)
  UserParty.create!(viewing_party: ViewingParty.last, user: User.last, host: false)
end