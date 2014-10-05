require 'nexpose'
require 'yaml'
require 'nmap'
require_relative 'nexpose_edit'
require_relative 'nmap_load'

v1 = ARGV[0]
if v1.nil?
  conf_file = "conf.yml"
else
  conf_file = v1
end

#Loading conf variables from YAML file
begin
  config = YAML.load_file(conf_file)
  nmap_xml = config["nmap_xml"]
  instance_name = config["nexpose_host"]
  instace_port = config["nexpose_port"]
  username = config["nexpose_user"]
  password = config["nexpose_pass"]
  nexpose_site = config["nexpose_site"]
rescue ArgumentError => e
  puts "Could not parse conf YAML: #{e.message}"
end

#Running the method nmap_load which uses the namp gem to load our nmap results xml
new_ip = Array.new
new_ip = nmap_load(nmap_xml)

if new_ip.any?
  begin
    puts "New ip has been found, going to update Nexpose"
    #Running the method which uses the nexpose gem to update our specified site
    nexpose_edit_site(instance_name,username,password,nexpose_site,new_ip)
    #Rescuing any error if there is an issue
  rescue ArgumentError => e
    puts "Could not update Nexpose: #{e.message}"
  end
else
  puts "No changes found"
end
