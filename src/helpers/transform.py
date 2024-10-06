def transform(df):
    """Apply transformations to the DataFrame."""    
    df = df.drop(columns=['index'])
    return df