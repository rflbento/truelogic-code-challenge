def remove_invalid_elements(array)
  # Remove empty elements
  array_valid_elements_only = array.reject { |element| element.empty? }

  # Remove headers and footers
  array_valid_elements_only[3..array_valid_elements_only.length - 3]
end

def organize_weather_values(array)
  array.each_with_object([]) do |weather_data, list|
    weather_hash = {
      day: weather_data[0].to_i,
      max: weather_data[1].to_f,
      min: weather_data[2].to_f
    }

    list << weather_hash
  end
end

file_data = File.open(ARGV.first, File::RDONLY){|f| f.read }
file_data_array = file_data.lines.map(&:split)

weather_values = remove_invalid_elements(file_data_array)
weather_registers = organize_weather_values(weather_values)

least_variation_register = weather_registers.min_by { |register| register[:max] - register[:min] }

day = least_variation_register[:day]
variation = least_variation_register[:max] - least_variation_register[:min]

puts "The day with the least temperature variation is the day #{day}, with a variation of #{variation} degree(s). " \
  "The maximum temperature is #{least_variation_register[:max]} and the minimum is #{least_variation_register[:min]}."
