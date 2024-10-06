import awswrangler as wr

class AWSWrangler:
    
    def __init__(self, logger):
        
        self.wrangler = wr
        self.logger = logger

    def read_csv(self, path):
        if path.split('.')[-1] != 'csv':
            raise ValueError('Only CSV files are supported')
        
        return self.wrangler.s3.read_csv(path)