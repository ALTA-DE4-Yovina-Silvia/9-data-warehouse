CREATE TABLE events_columnar (
	device_id bigint,
	event_id bigserial,
	event_time timestamptz default now(),
	data jsonb not null
)
USING columnar;
--insert some data
INSERT INTO events_columnar (device_id, data)
SELECT d, '{"hello": "columnar"}' FROM generate_series (1, 100000) d;

--create a row-based table to compare
CREATE TABLE events_row AS SELECT * FROM events_columnar;

--select * from events_columnar
--select * from events_row 





