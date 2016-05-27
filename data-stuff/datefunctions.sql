-- from https://github.com/ankane/groupdate.sql, minimal functions

BEGIN;

-- version

CREATE OR REPLACE FUNCTION gd_version()
  RETURNS text AS
$$
  SELECT '1.0.0'::text;
$$
  LANGUAGE SQL;

-- month

CREATE OR REPLACE FUNCTION gd_month(timestamptz)
  RETURNS timestamptz AS
$$
  SELECT DATE_TRUNC('month', $1)::timestamptz;
$$
  LANGUAGE SQL STABLE;


CREATE OR REPLACE FUNCTION gd_month(timestamp)
  RETURNS timestamptz AS
$$
  SELECT gd_month($1::timestamptz);
$$
  LANGUAGE SQL STABLE;


-- month w/ time zone

CREATE OR REPLACE FUNCTION gd_month(timestamptz, text)
  RETURNS timestamptz AS
$$
  SELECT DATE_TRUNC('month', $1 AT TIME ZONE $2) AT TIME ZONE $2;
$$
  LANGUAGE SQL STABLE;


CREATE OR REPLACE FUNCTION gd_month(timestamp, text)
  RETURNS timestamptz AS
$$
  SELECT gd_month($1::timestamptz, $2);
$$
  LANGUAGE SQL STABLE;


-- hour of day

CREATE OR REPLACE FUNCTION gd_hour_of_day(timestamptz)
  RETURNS integer AS
$$
  SELECT EXTRACT(HOUR FROM $1)::integer;
$$
  LANGUAGE SQL STABLE;


CREATE OR REPLACE FUNCTION gd_hour_of_day(timestamp)
  RETURNS integer AS
$$
  SELECT gd_hour_of_day($1::timestamptz);
$$
  LANGUAGE SQL STABLE;


-- hour of day w/ time zone

CREATE OR REPLACE FUNCTION gd_hour_of_day(timestamptz, text)
  RETURNS integer AS
$$
  SELECT EXTRACT(HOUR FROM $1 AT TIME ZONE $2)::integer;
$$
  LANGUAGE SQL STABLE;


CREATE OR REPLACE FUNCTION gd_hour_of_day(timestamp, text)
  RETURNS integer AS
$$
  SELECT gd_hour_of_day($1::timestamptz, $2);
$$
  LANGUAGE SQL STABLE;


-- day of week

CREATE OR REPLACE FUNCTION gd_day_of_week(timestamptz)
  RETURNS integer AS
$$
  SELECT EXTRACT(DOW FROM $1)::integer;
$$
  LANGUAGE SQL STABLE;


CREATE OR REPLACE FUNCTION gd_day_of_week(timestamp)
  RETURNS integer AS
$$
  SELECT gd_day_of_week($1::timestamptz);
$$
  LANGUAGE SQL STABLE;


-- day of week w/ time zone

CREATE OR REPLACE FUNCTION gd_day_of_week(timestamptz, text)
  RETURNS integer AS
$$
  SELECT EXTRACT(DOW FROM $1 AT TIME ZONE $2)::integer;
$$
  LANGUAGE SQL STABLE;


CREATE OR REPLACE FUNCTION gd_day_of_week(timestamp, text)
  RETURNS integer AS
$$
  SELECT gd_day_of_week($1::timestamptz, $2);
$$
  LANGUAGE SQL STABLE;

COMMIT;
