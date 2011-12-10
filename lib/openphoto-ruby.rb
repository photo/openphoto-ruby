require "openphoto-ruby/version"

module Openphoto
  def self.portray(food)
    if food.downcase == "broccoli"
      "Gross!"
    else
      "Delicious!"
    end
  end
end

