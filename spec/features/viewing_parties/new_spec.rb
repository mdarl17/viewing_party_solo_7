require "rails_helper" 

RSpec.describe "New Viewing Party page", :vcr, type: :feature do 
  before(:each) do 
    load_test_data
    @movie_id = 264660
    @facade = MovieFacade.new(top_movies: false, keywords: nil, movie_id: @movie_id)
  end
   describe "a user creates a new viewing party" do 
    it "has a form users can fill out and submit to make a new viewing party" do 
      visit new_viewing_party_path(user_id: User.first.id, movie_id: @movie_id)

      expect(page).to have_content(@facade.movies.title)
      expect(page).to have_field(:duration)
      expect(page).to have_field(:date)
      expect(page).to have_field(:start_time)
      expect(page).to have_field(:guest_1)
      expect(page).to have_field(:guest_2)
      expect(page).to have_field(:guest_3)

      expect(page).to have_button("Create Party")
    end

    # happy path
    it "when the form is submitted a new user will be created" do 
      user = User.last

      visit new_viewing_party_path(user_id: user.id, movie_id: @movie_id)

      fill_in :duration, with: @facade.movies.runtime + 45
      fill_in :date, with: "05/12/24"
      fill_in :start_time, with: "7:00"
      fill_in :guest_1, with: User.first.email
      fill_in :guest_2, with: User.second.email
      fill_in :guest_3, with: User.third.email

      click_button "Create Party"

      expect(current_path).to eq(user_dashboard_path(user.id))
    end

    # sad path 
    it "will not create a viewing party if the party duration is shorter than the movie length" do 
      visit new_viewing_party_path(user_id: User.last.id, movie_id: @movie_id)

      fill_in :duration, with: @facade.movies.runtime - 45
      fill_in :date, with: "05/12/24"
      fill_in :start_time, with: "7:00"
      fill_in :guest_1, with: User.first.email
      fill_in :guest_2, with: User.second.email
      fill_in :guest_3, with: User.third.email

      click_button "Create Party"

      expect(current_path).to eq(new_viewing_party_path(User.last.id, @movie.id))
      expect(page).to have_content("The party duration can't be shorter than the movie runtime")
    end

    it "adds a movie to the viewing party to the viewing party" do 
      visit new_viewing_party_path(user_id: User.last.id, movie_id: @movie_id)

      fill_in :duration, with: @facade.movies.runtime + 45
      fill_in :date, with: "05/12/24"
      fill_in :start_time, with: "7:00"
      fill_in :guest_1, with: User.first.email
      fill_in :guest_2, with: User.second.email
      fill_in :guest_3, with: User.third.email

      expect(ViewingParty.count).to eq(5)
      
      click_button "Create Party"
      
      expect(ViewingParty.count).to eq(6)
      expect(ViewingParty.last.movie_id).to eq(@movie_id)
    end
  end
end 