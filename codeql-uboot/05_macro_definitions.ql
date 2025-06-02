import cpp

from Macro mac
where mac.getName() = "ntohs" or mac.getName() = "ntohl" or  mac.getName() = "ntohll"
select mac, "Macro Found"