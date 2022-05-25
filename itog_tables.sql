create schema dim;
create schema fact;

create table  dim.date(
    id int not null primary key,
    dt date,
    ansi_date char(10),
    day int,
    week_number int,
    month int,
    year int,
    week_day smallint,
    holyday bool
);

 create table dim.passengers(
	passenger_id varchar(20) not null primary key,
	passenger_name varchar(140),
	total_amount numeric(10,2),
	last_book_date date
);

create table dim.aircrafts(
	aircraft_code  bpchar(3) not null primary key,
	model text,
	range int,
	capacity int,
	business_seats int,
	comfort_seats int,
	economy_seats int
);

create table dim.airports(
	 airport_code bpchar(3) not null primary key,
	 name text,
	 city text,
	 total_flights int,
	 longitude float(8),
	 latitude float(8)
);

create table dim.tariff(
	fare_conditions varchar(10) not null primary key,
	avg_amount numeric(10,2)
);

create table fact.flights(
	passenger_id varchar(20) not null references dim.passengers(passenger_id),
	actual_departure_id int4 not null references dim.date(id),
	actual_arrival_id int4 not null references dim.date(id),
	departure_delay_seconds int,
	arrival_delay_seconds int,
    aircraft_code bpchar(3) not null references dim.aircrafts(aircraft_code),
	departure_airport_code bpchar(3) not null references dim.airports(airport_code),
	arrival_airport_code bpchar(3) not null references dim.airports(airport_code),
	fare_conditions varchar(10) not null references dim.tariff(fare_conditions ),
	amount numeric(10, 2)
);