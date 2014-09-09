require 'csv'

Enumerable.class_eval do
  def mode
    group_by do |e|
      e
    end.values.max_by(&:size).first
  end
  def antimode
  	group_by do |e|
      e
    end.values.min_by(&:size).first
  end
end

class Array
  # monkey-patched version
  def dup_hash
    inject(Hash.new(0)) { |h,e| h[e] += 1; h }
  end
end


data_array = CSV.read('data.csv', headers:true)
score_array_temp = data_array['Score']
color_array = data_array['Color']
# puts data_array
min_color = color_array.antimode()
max_score = score_array_temp.max
min_score = score_array_temp.min
data_array.each do |row|
	name = row['Name'].split(" ").map { |word| word.capitalize }.join(" ")
	if row['Score'] == max_score
		puts "Name Max: #{name}" #=> Get Max Score student
	elsif row['Score'] == min_score
		puts "Name Min: #{name}"
	end
end

score_array = score_array_temp.collect{|i| i.to_f}
sum = score_array.inject(:+)
puts "Average: #{(sum/ score_array.size)}"
puts "Most Color: #{color_array.mode()}"
print "Least Color:"
h = color_array.dup_hash()
h.each do |row|
	if(row[1] == h[color_array.antimode()])
		print " #{row[0]}"
	end
end
puts ""

# 1. Which student has the highest score in the class? Lowest?
# 2. What is the mean of all student’s scores?
# 3. What is the most popular color among students? Least popular?
# 4. Capitalize the last letter of first name and last name, and lowercase the first letter of first 
# name and last name.