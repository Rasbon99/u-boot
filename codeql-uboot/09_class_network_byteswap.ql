/**
 * @id 09-class-network-byteswap
 * @problem.severity warning
 * @kind problem
 */

import cpp

    class NetworkByteSwap extends Expr {
      NetworkByteSwap () {
        exists(MacroInvocation macInv |
          (macInv.getMacroName() = "ntohs" or macInv.getMacroName() = "ntohl" or  macInv.getMacroName() = "ntohll") and  this = macInv.getExpr()
        )
      }
    }

    from NetworkByteSwap n
    select n, "Network byte swap"