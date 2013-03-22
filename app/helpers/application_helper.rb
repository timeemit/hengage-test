module ApplicationHelper
  def display_time(time)
    time.strftime('%b %d, %Y @ %H:%M:%S') if time.is_a? Time
  end
end
