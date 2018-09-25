curl -s "http://ec2-54-144-55-41.compute-1.amazonaws.com:19999/api/v1/data?chart=system.cpu&after=-10&format=json&options=nonzero" | jq "[ .data[] | nth(2)] | add / length";
