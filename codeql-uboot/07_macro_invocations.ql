/**
 * @id 07-macro-invocations
 * @problem.severity warning
 * @kind problem
 */


import cpp

from MacroInvocation macInv
where macInv.getMacroName() = "ntohs" or macInv.getMacroName() = "ntohl" or  macInv.getMacroName() = "ntohll"
select macInv, "Macro Invocation Found"