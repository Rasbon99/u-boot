/**
 * @id 05-macro-definitions
 * @problem.severity warning
 * @kind problem
 */

import cpp

from Macro mac
where mac.getName() = "ntohs" or mac.getName() = "ntohl" or  mac.getName() = "ntohll"
select mac, "Macro Found"