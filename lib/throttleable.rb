module Throttleable
  # Blocks execution of the block until the time_since_last_request has
  # exceeded the throttle_delay.
  def throttle(&block)
    sleep(delay)
    @last_request_at = now

    yield
  end

  def throttle_delay
    raise
  end

  def now
    Time.now.to_f
  end

  def delay
    if time_since_last_request < throttle_delay
      (throttle_delay - time_since_last_request)
    else
      0
    end
  end

  def time_since_last_request
    (now - @last_request_at.to_f)
  end
end
