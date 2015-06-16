module PageHelper

  def calendar(month, year)


    current_date= Date.new(year, month, 1)

    prev_month = month -1
    prev_year = year

    if (prev_month < 1)
      prev_month = 12
      prev_year = year - 1
    end

    next_month = month + 1
    next_year = year
    if (next_month > 12)
      next_month = 1
      next_year = year + 1
    end

    cal = ""
    #"/page/calendar?month=#{prev_month}&year=#{prev_year}"
    cal += link_to "Prev", calendar_path(:month => prev_month, :year => prev_year)

    cal += "\t" + current_date.strftime("%B")

    cal += "\t" + year.to_s

    cal += "\t"
    cal += link_to "Next", calendar_path(:month => next_month, :year => next_year)

    day_of_week = current_date.strftime("%w").to_i

    days_in_month = Time.days_in_month(month, year)
    days_left = days_in_month
    day_count = 0
    total_weeks = current_date.total_weeks

    cal += "<table border='1'>\n\t<tr>\n"
    days = %w(Sun Mon Tue Wed Thu Fri Sat)
    days.each do |day|
      cal += "\t\t<td> #{day} </td>\n"
    end

    #second row - first week of the month
    cal += "<tr>"

    # first week, blank cells
    day_of_week.times do |day|
      cal += "<td>&nbsp;</td>"
    end

    #first week
    (7 - day_of_week).times do |day|
      cal += "<td>#{day + 1}</td>"
      day_count += 1
    end
    total_weeks = total_weeks - 1
    cal += "</tr>"

    #loop to do the in between rows
    while (total_weeks > 1) do
      cal += "<tr>"
      7.times do |day|
        day_count += 1
        cal += "<td>#{day_count}</td>"
      end

      cal += "</tr>"
      total_weeks = total_weeks - 1
    end

    #final loop to do the last week
    cal += "<tr>"
    diff = days_in_month - day_count
    diff.times do |day|
      day_count += 1
      cal += "<td>#{day_count}</td>"

    end

    #last week blank cells
    (7 - diff).times do |day|
      cal += "<td>&nbsp;</td>"
    end
    cal += "</tr>"


    cal += "\t</tr>\n</table>\n"
    cal += "Month: #{month} <br/> Year: #{year}<br/>"
    cal += "Date: #{current_date}<br/>"
    cal += "Days of the week: " + day_of_week.to_s + "<br/>"
    cal += "Days in month: " + days_in_month.to_s + "<br/>"
    cal += "Days left: " + days_left.to_s + "<br/>"
    cal += "Total weeks: " + total_weeks.to_s + "<br/>"
    return cal
  end
end
