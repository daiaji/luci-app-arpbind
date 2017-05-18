local t=require"luci.sys"
local e=t.net:devices()
m=Map("arpbind",translate("IP/MAC Binding"),
translatef("ARP is used to convert a network address (e.g. an IPv4 address) to a physical address such as a MAC address.Here you can add some static ARP binding rules."))
s=m:section(TypedSection,"arpbind",translate("Rules"))
s.template="cbi/tblsection"
s.anonymous=true
s.addremove=true
nolimit_ip=s:option(Value,"ipaddr",translate("IP Address"))
nolimit_ip.datatype="ipaddr"
nolimit_ip.optional=false
nolimit_mac=s:option(Value,"macaddr",translate("MAC Address"))
nolimit_mac.datatype="macaddr"
nolimit_mac.optional=false
a=s:option(ListValue,"ifname",translate("Interface"))
for t,e in ipairs(e)do
if e~="lo"then
a:value(e)
end
end
a.default="br-lan"
a.rmempty=false
t.net.arptable(function(e)
nolimit_ip:value(e["IP address"])
nolimit_mac:value(
e["HW address"],
e["HW address"].." ("..e["IP address"]..")"
)
end)
return m