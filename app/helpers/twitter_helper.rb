module TwitterHelper

  def convert_date(date)
    date_format = DateTime.parse(date).to_time
    distance_of_time_in_words(Time.now, date_format)
  end

end