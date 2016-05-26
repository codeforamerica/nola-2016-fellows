# encoding:UTF-8
# !/usr/bin/env ruby
require 'CSV'

def process_csv(file_name)
  processed_name = file_name.dup.insert(-5, '-processed')
  processed_csv = CSV.new(File.new(processed_name, 'wt'), headers: true)
  processed_csv << CSV.parse_line('ID,Name,Date_In,Arrived,Started,Completed,Wait_Time,Service_Time,Service_Description,Completed_By')

  CSV.foreach(file_name, headers: true) do |row|
    row['Wait_Time'] = strtime_to_min(row['Wait_Time'])
    row['Service_Time'] = strtime_to_min(row['Service_Time'])
    processed_csv << row
  end

  processed_csv.close
end

def strtime_to_min(string_time)
  hour, min = 0
  string_time.match(/(\d\d)h (\d\d)m/) do |match|
    hour = match[1].to_i
    min = match[2].to_i
  end
  (hour * 60) + min # convert to minutes
end

file_name = ARGV.first
process_csv file_name
