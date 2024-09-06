def remove_invalid_elements(array)
  # Remove non-valid elements
  array_valid_elements_only = array.reject { |element| element.size <= 1 }

  # Remove headers and footers
  array_valid_elements_only[0..array_valid_elements_only.length - 1]
end

def organize_team_info(array)
  headers = ['Pos'] + array[0]

  array[1..array.size - 1].each_with_object([]) do |team_info, list|
    team_hash = {}
    n_header = 0

    team_info.each do |value|
      next if value == '-'

      team_hash[headers[n_header].downcase.to_sym] = value

      n_header += 1
    end

    list << team_hash
  end
end

file_data = File.open(ARGV.first, File::RDONLY){|f| f.read }
file_data_array = file_data.lines.map(&:split)

teams_info = remove_invalid_elements(file_data_array)
teams_registers = organize_team_info(teams_info)

team = teams_registers.min_by { |register| (register[:f].to_i - register[:a].to_i).abs }
goals_difference = (team[:f].to_i - team[:a].to_i).abs

puts "The team with the lowest goals difference is #{team[:team]}, scoring #{team[:f]} goal(s) and " \
  "conceding #{team[:a]} goal(s), resulting in a difference of #{goals_difference} goal(s)."
