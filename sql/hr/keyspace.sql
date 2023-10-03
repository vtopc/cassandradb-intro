-- Create a keyspace
CREATE KEYSPACE IF NOT EXISTS hr WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };
