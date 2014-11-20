module FeedHelper
  include ApplicationHelper

  # applies rounding to an enumerable object
  def object_round(object, round=nil, match='field')
    object.each_with_index do |o, index|
      object[index] = item_round(o, round, match)
    end

    return object
  end
end
