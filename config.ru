# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

puts "Erasing job.txt..."
job_txt = File.open('job.txt', "w")
job_txt.write("")
puts File.read("job.txt").length == 0 ? "Done." : "Failed."
job_txt.close

run Rails.application
Rails.application.load_server