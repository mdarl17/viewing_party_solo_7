require "rails_helper" 

RSpec.describe "New Viewing Party page", type: :feature do 
  before(:each) do 
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @movie_id = 264660
  end
   describe "a user creates a new viewing party" do 
    it "has a form users can fill out and submit to make a new viewing party" do 
      visit new_viewing_party_path(user_id: @user.id, movie_id: @movie.id)

      expect(page).to have_content(@movie.title)
      expect(page).to have_content(@viewing_party.duration)
      expect(page).to have_content(@viewing_party.date)
      expect(page).to have_content(@viewing_party.start_time)
      expect(page).to have_field(:guest_1)
      expect(page).to have_field(:guest_2)
      expect(page).to have_field(:guest_3)
      expect(page).to have_button("Create Party")

      expect(current_path).to eq(viewing_party_dashboard_path)
    end
   end
end 