require 'nmap/xml'

def nmap_load(nmap_xml)
begin
res = Array.new
  Nmap::XML.new(nmap_xml) do |xml|
    xml.each_up_host do |host|
    if host.open_ports.any?
      res << host.ip
      end
    end
  end
puts res

rescue Exception => e
       return "Runy-Nmap gem Error: #{e.to_s}"
 end
end

nmap_load('test.xml')
