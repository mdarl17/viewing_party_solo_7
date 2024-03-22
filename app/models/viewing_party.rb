class ViewingParty < ApplicationRecord
   has_many :user_parties
   has_many :users, through: :user_parties

   def self.duration_valid?(params, movie)
      params[:duration].to_i > movie.runtime
   end

   def find_host
      users.where("user_parties.host = true").first
   end

   def parse_guests(params)
      guests = []
      params.each do |param, val|
        if param.include?("guest") 
          guests << val
        end
      end
      guests
   end
end
