# pgminmax
PostgreSQL Extension to return MIN and MAX values in an aggregation

Can use this command to define in your session the output format where _MIN_ and _MAX_ will be replaced with the values

SET min_max.format TO '_MIN_ -> _MAX_'

or put in the postgresql.conf

min_max.format = '_MIN_ -> _MAX_'


