/**
 * @id 06-memcpy-calls
 * @problem.severity warning
 * @kind problem
 */

import cpp

from FunctionCall call, Function fcn
where
    call.getTarget() = fcn and
    fcn.getName() = "memcpy"
select call, "Function Call Found"