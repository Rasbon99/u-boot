/**
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
}

module MyTaint = TaintTracking::Global<MyConfig>;

import MyTaint::PathGraph

from MyTaint::PathNode source, MyTaint::PathNode sink
where MyTaint::flowPath(source, sink)
select sink.getNode(), source, sink, "Network byte swap flows to memcpy"
