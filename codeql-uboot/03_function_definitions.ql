/**
 * @id 03-function-definitions
 * @problem.severity warning
 * @kind problem
 */

import cpp

from Function f
where f.getName() = "strlen"
select f, "Function Fuond"


