import cpp

from MacroInvocation macInv
where macInv.getMacroName() = "ntohs" or macInv.getMacroName() = "ntohl" or  macInv.getMacroName() = "ntohll"
select macInv, macInv.getExpr()