module ProjectsHelper
  def rounded_hours_from_seconds(seconds)
    i = seconds/60
    r = seconds % 60.0 
    if r >= 7.5 and r < 22.5
      i += 0.25
    elsif r >= 22.5 and r < 37.5
      i += 0.5
    elsif r >= 37.5 and r < 52.5
      i += 0.75
    elsif  r >= 52.5
      i += 1.0
    end
    i
  end
end
