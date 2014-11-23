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

  # gets the median for an object
  def object_median(object, comma_flag=false, round=nil)
    return nil if object.nil?
    length = object.length
    return nil if length == 0
    output = ''

    # do the calculation
    if length % 2 == 0
      output = (object[(length - 1) / 2] + object[length / 2]) / 2
    else
      output = object[(length - 1) / 2]
    end

    output = sprintf "%.#{round}f", output if round and is_a_number?(output)

    # replace decimals with commas if appropriate
    output = output.to_s.gsub(/\./, ',') if comma_flag

    return output.to_s
  end

  # averages a summed object over length
  def object_average(object, length, comma_flag=false, round=nil)
    object.attribute_names.each do |attr|
      # only average non-null integer fields
      if !object[attr].nil? and is_a_number?(object[attr])
        if round
          object[attr] = sprintf "%.#{round}f", (parsefloat(object[attr]) / length)
        else
          object[attr] = (parsefloat(object[attr]) / length).to_s
        end
        # replace decimals with commas if appropriate
        object[attr] = object[attr].gsub(/\./, ',') if comma_flag
      end
    end

    return object
  end

  # formats a summed object correctly
  def object_sum(object, comma_flag=false, round=nil)
    object.attribute_names.each do |attr|
      # only average non-null integer fields
      if !object[attr].nil? and is_a_number?(object[attr])
        if round
          object[attr] = sprintf "%.#{round}f", parsefloat(object[attr])
        else
          object[attr] = parsefloat(object[attr]).to_s
        end
        # replace decimals with commas if appropriate
        object[attr] = object[attr].gsub(/\./, ',') if comma_flag
      end
    end

    return object
  end

  def create_empty_clone(object)
    empty_clone = object.dup
    empty_clone.attribute_names.each { |attr| empty_clone[attr] = nil }
    return empty_clone
  end

  # get the time floored to the correct number of seconds
  def get_floored_time(input_time, seconds)
    floored_seconds = (input_time.to_f / seconds).floor * seconds
    # offset the seconds by the current time zone offset
    offset_seconds = Time.zone.now.utc_offset
    return Time.at(floored_seconds - offset_seconds)
  end

  # slice feed into timescales
  def feeds_into_timescales(feeds, params)

    # convert timescale (minutes) into seconds
    seconds = params[:timescale].to_i * 60
    # get floored time ranges
    start_time = get_floored_time(feeds.first.created_at, seconds)
    end_time = get_floored_time(feeds.last.created_at, seconds)

    # create empty array with appropriate size
    timeslices = Array.new((((end_time - start_time) / seconds).abs).floor)

    # create a blank clone of the first feed so that we only get the necessary attributes
    empty_feed = create_empty_clone(feeds.first)

    # add feeds to array
    feeds.each do |f|
      i = ((f.created_at - start_time) / seconds).floor
      f.created_at = start_time + i * seconds
      timeslices[i] = f if timeslices[i].nil?
    end

    # fill in empty array elements
    timeslices.each_index do |i|
      if timeslices[i].nil?
        current_feed = empty_feed.dup
        current_feed.created_at = (start_time + (i * seconds))
        timeslices[i] = current_feed
      end
    end

    return timeslices
  end

  # slice feed into sums
  def feeds_into_sums(feeds, params)
    # convert timescale (minutes) into seconds
    seconds = params[:sum].to_i * 60
    # get floored time ranges
    start_time = get_floored_time(feeds.first.created_at, seconds)
    end_time = get_floored_time(feeds.last.created_at, seconds)

    # create empty array with appropriate size
    timeslices = Array.new((((end_time - start_time) / seconds).abs).floor)

    # create a blank clone of the first feed so that we only get the necessary attributes
    empty_feed = create_empty_clone(feeds.first)

    # add feeds to array
    feeds.each do |f|
      i = ((f.created_at - start_time) / seconds).floor
      f.created_at = start_time + i * seconds
      # create multidimensional array
      timeslices[i] = [] if timeslices[i].nil?
      timeslices[i].push(f)
    end

    # keep track of whether numbers use commas as decimals
    comma_flag = false

    # fill in array
    timeslices.each_index do |i|
      # insert empty values
      if timeslices[i].nil?
        current_feed = empty_feed.dup
        current_feed.created_at = (start_time + (i * seconds))
        timeslices[i] = current_feed
        # else sum the inner array
      else
        sum_feed = empty_feed.dup
        sum_feed.created_at = timeslices[i].first.created_at
        # for each feed
        timeslices[i].each do |f|
          # for each attribute, add to sum_feed so that we have the total
          sum_feed.attribute_names.each do |attr|
            # only add non-null integer fields
            if attr.index('field') and !f[attr].nil? and is_a_number?(f[attr])

              # set comma_flag once if we find a number with a comma
              comma_flag = true if !comma_flag and f[attr].to_s.index(',')

              # set initial data
              if sum_feed[attr].nil?
                sum_feed[attr] = parsefloat(f[attr])
                # add data
              elsif f[attr]
                sum_feed[attr] = parsefloat(sum_feed[attr]) + parsefloat(f[attr])
              end

            end
          end
        end

        # set to the summed feed
        timeslices[i] = object_sum(sum_feed, comma_flag, params[:round])
      end
    end

    return timeslices
  end

end
