/**
 * @id 10-taint-tracking-inpv
 * @problem.severity error
 * @kind path-problem
 */


import cpp
import semmle.code.cpp.dataflow.TaintTracking

class NetworkByteSwap extends Expr {
  NetworkByteSwap() {
    exists(MacroInvocation macInv |
      (
        macInv.getMacroName() = "ntohs" or
        macInv.getMacroName() = "ntohl" or
        macInv.getMacroName() = "ntohll"
      ) and
      this = macInv.getExpr()
    )
  }
}

module MyConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source.asExpr() instanceof NetworkByteSwap }

  predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall call, Function fun |
      call.getTarget() = fun and
      fun.getName() = "memcpy" and
      sink.asExpr() = call.getArgument(2)
    )
  }

  predicate isBarrier(DataFlow::Node barrier) {
    exists( IfStmt ifs | 
      barrier.asExpr().getBasicBlock() = ifs )
  }
}

module MyTaint = TaintTracking::Global<MyConfig>;

import MyTaint::PathGraph

from MyTaint::PathNode source, MyTaint::PathNode sink, MyTaint::PathNode barrier
where MyTaint::flowPath(source, sink) and not 
     (MyTaint::flowPath(source, barrier) and MyTaint::flowPath(barrier, sink))
select sink, source, sink, "Network byte swap flows to memcpy"
