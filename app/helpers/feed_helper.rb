module FeedHelper
  include ApplicationHelper

  # applies rounding to an enumerable object
  def object_round(object, round=nil, match='field')
    object.each_with_index do |o, index|
      object[index] = item_round(o, round, match)
    end

    return object
  end

  # applies rounding to a single item's attributes if necessary
  def item_round(item, round=nil, match='field')
    return nil if item.nil?

    # for each attribute
    item.attribute_names.each do |attr|
      # only add non-null numeric fields
      if attr.index(match) and !item[attr].nil? and is_a_number?(item[attr])
        # keep track of whether the value contains commas
        comma_flag = (item[attr].to_s.index(',')) ? true : false

        # replace commas with decimals if appropriate
        item[attr] = item[attr].to_s.gsub(/,/, '.') if comma_flag

        # do the actual rounding
        item[attr] = sprintf "%.#{round}f", item[attr]

        # replace decimals with commas if appropriate
        item[attr] = item[attr].to_s.gsub(/\./, ',') if comma_flag
      end
    end

    # output new item
    return item
  end


  
end
