import awswrangler as wr

class AWSWrangler:
    
    def __init__(self, logger, db_conn):
        self.wrangler = wr
        self.logger = logger
        self.db_conn = db_conn  # Accepting a DBConn instance

    def read_csv(self, path):
        if path.split('.')[-1] != 'csv':
            raise ValueError('Only CSV files are supported')
        
        return self.wrangler.s3.read_csv(path, sep=";") # TODO: Add sep handler

    def insert_db(self, df, table_name):
        """Insert data into the MySQL database and close connection afterward."""
        with self.db_conn.get_conn() as con_mysql:  # Connection is managed automatically
            wr.mysql.to_sql(df, con_mysql, schema=self.db_conn.credentials['db_name'], table=table_name, mode="overwrite")            