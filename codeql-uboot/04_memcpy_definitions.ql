/**
 * @id 04-memcpy-definitions
 * @problem.severity warning
 * @kind problem
 */

import cpp

from Function f
where f.getName() = "memcpy"
select f, "Function Fuond"
