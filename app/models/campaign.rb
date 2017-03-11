class Campaign < ApplicationRecord
  has_many :song
  has_many :campaign_link

  def finished?(curr_time = Time.now)
    return false if !buy_end    # Buy end is unknown / undefined

    curr_time > buy_end
  end

  def buy_phase?(curr_time = Time.now)
    return false if !buy_start                    # Buy start is unknown / undefined
    return (curr_time > buy_start) if !buy_end    # Buy start is known, buy end is unknown / undefined
      
    (buy_start..buy_end).covers?(curr_time)
  end

  def pledge_phase?(curr_time = Time.now)
    return false if !pledge_start                       # Pledge start is unknown / undefined
    return (curr_time > pledge_start) if !pledge_end    # Pledge start is known, pledge end is unknown / undefined

    (pledge_start..pledge_end).covers?(curr_time)
  end

  def time_left_to_buy(curr_time = Time.now)
    if finished?
      return 0
    elsif buy_phase?
      return buy_end - curr_time
    else
      return nil
    end
  end

  def time_until_buy(curr_time = Time.now)
    if finished?(curr_time) || buy_phase?(curr_time)
      return 0
    else
      return buy_start - curr_time
    end
  end
end
