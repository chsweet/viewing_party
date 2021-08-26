class Actor
  attr_reader :name,
              :role
  def initialize (data)
    @name = data[:name]
    @role = data[:character]
    @department = data[:known_for_department]
  end
end
