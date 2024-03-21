class CastPoro 
  attr_reader :actor, :character

  def initialize(attributes)
    @id = attributes[:id]
    @actor = attributes[:name]
    @character = attributes[:character]
  end
end