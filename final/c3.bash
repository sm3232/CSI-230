#!/bin/bash
if [[ $# -lt 1 ]]; then
	echo "Not enough args.";
	echo "Usage: c3.bash [report file]";
	exit 1;
fi

report=$(cat "$1" | awk '{print "<tr><td>"$1"</td><td>"$2"</td><td>"$3"</td></tr>"}')
printf '%s\n' "<html>
	<head>
		<style>
			table,th,td{border:1px solid black}
		</style>
	</head>
	<body>
		<table>
			<tbody>
				$report
			</tbody>
		</table>
	</body>
</html>" | tr -d '\r' > /var/www/html/report.html
