module Succotash
	require 'fileutils'
	require 'csv'
	def self.parse_csv_and_create_a_hash
		row_count = 0
		data_hash = {}
		headers_hash = {}
		headers_hash['headers'] = {}
		CSV.foreach("#{Dir.pwd}/tmp/test_succotash.csv") do |row|
			unless row_count < 1
				row.each_with_index do |col_val,index|
					col_name = headers_hash['headers'][index]['code_name']
					unless col_name == nil
						unless index < 1
							data_hash["row_#{row_count}"][col_name] = col_val
						else
							data_hash["row_#{row_count}"] = {}
							data_hash["row_#{row_count}"][col_name] = col_val
						end
					end
				end
			else
				# First row is always considered as headers in CSV or the columns in CSV.
				row.each_with_index do |col_name,index|
					# headers_hash['headers']["actual_header_#{index}"] = col_name
					headers_hash['headers'][index] = {}
					headers_hash['headers'][index]['actual_name'] = col_name
					headers_hash['headers'][index]['code_name'] = "#{col_name.downcase.gsub(/[^A-Za-z0-9\-_]+/, '_')}_#{index}"
				end
			end
			row_count += 1
		end
		return headers_hash,data_hash
	end

  def self.formula(formula, values)
    # remove anything but Q's, numbers, ()'s, decimal points, and basic math operators 
    formula.gsub!(/((?![qQ0-9\s\.\-\+\*\/\(\)]).)*/,'').upcase!
    p formula
    begin
      formula.gsub!(/Q\d+/) { |match|
        ( 
          values[match.to_sym] && 
          values[match.to_sym].class.ancestors.include?(Numeric) ?
          values[match.to_sym].to_s :
          '0'
        )+'.0'
      }
      instance_eval(formula)
    rescue Exception => e
      e.inspect
    end
  end

	def self.format_report
		headers_hash,data_hash = parse_csv_and_create_a_hash
		p 'These are the following headers'
		p headers_hash['headers']
		p 'The Data hash is '
		p data_hash
		p 'Do you wnat to create new headers ? Yes/NO(Y/N)'
		loop do 
			new_headers = gets.chomp().downcase 
			new_headers = new_headers == 'y' || new_headers == 'yes' ? true : false
			break if new_headers == false
			@new_col_index = headers_hash['headers'].count
			headers_hash['headers'][@new_col_index] = {}
			p 'Please enter the name of the column'
			new_column_name = gets.chomp()
			headers_hash['headers'][@new_col_index]['actual_name'] = new_column_name
			headers_hash['headers'][@new_col_index]['code_name'] = "#{new_column_name.downcase.gsub(/[^A-Za-z0-9\-_]+/, '_')}_#{@new_col_index}"
			loop do 
				p 'Please enter the index and code name of the from column name - Line seperated.'
				@user_entered_index = gets.chomp.to_i
				@user_entered_code_name = gets.chomp()
				break if headers_hash['headers'][@user_entered_index]['code_name'] == @user_entered_code_name
			end
			p 'Please write a expression '
			p " On the left hand side you have #{headers_hash['headers'][@new_col_index]['code_name']}"
			p " Write the right hand side of the expression - Variable name is #{@user_entered_code_name}"
			p " #{headers_hash['headers'][@new_col_index]['code_name']} = "
			expression = gets.chomp()
			p expression
			data_hash.each_with_index do |(key,value),index|
				p key
				p value[@user_entered_code_name]
				value_expression = expression.gsub("#{@user_entered_code_name}",value[@user_entered_code_name])
				p "The final value expression is #{value_expression}"
				data_hash[key][headers_hash['headers'][@new_col_index]['code_name']] = eval(value_expression)
			end
			p data_hash		
		end
	end
end

Succotash.format_report









