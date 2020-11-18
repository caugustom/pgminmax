
\echo Use "CREATE EXTENSION minmax" to load this file. \quit


CREATE OR REPLACE FUNCTION min_max_compare (anyarray, anyelement)
RETURNS anyarray AS
$$
        SELECT (ARRAY[ LEAST( $1[1],$2), GREATEST($1[2],$2) ]);
$$ LANGUAGE 'sql' STRICT;


CREATE OR REPLACE FUNCTION min_max_final(anyarray)
RETURNS text AS
$$
/*
Can use this command to define the output format where _MIN_ and _MAX_ will be replaced with the values

SET min_max.format TO '_MIN_ -> _MAX_'

or put in the postgresql.conf

min_max.format = '_MIN_ -->> _MAX_'

*/
        SELECT REPLACE(REPLACE(COALESCE(current_setting('min_max.format'),'_MIN_ -> _MAX_'),'_MIN_', $1[1]::text),'_MAX_', $1[2]::text)
$$ LANGUAGE 'sql' STRICT;



CREATE AGGREGATE min_max(anyelement)
(
        INITCOND = '{}',
        STYPE = anyarray,
        SFUNC = min_max_compare,
        FINALFUNC = min_max_final
);

