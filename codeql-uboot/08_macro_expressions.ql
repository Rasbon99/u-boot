/**
 * @id 08-macro-expressions
 * @problem.severity warning
 * @kind problem
 */

import cpp

from MacroInvocation macInv, Expr arg
where macInv.getMacroName() in ["ntohs", "ntohl", "ntohll"]
  and arg = macInv.getExpr()
  and not exists(ConditionalExpr ce | ce = arg)
select macInv.getMacroName(), arg.toString()