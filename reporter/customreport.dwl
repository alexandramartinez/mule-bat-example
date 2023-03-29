%dw 2.0
output application/json
var result = if (payload.result.pass[0]) " is ok" else " failed"
---
{
    (payload.name): {
		(payload.result.name[0]): payload.result[0].result map {
			($.result.name[0]): $.result.assertions[0] map {
				pass: $.pass,
				result: $.name
			}
		}
    }
}