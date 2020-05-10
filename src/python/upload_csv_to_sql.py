# Esse script faz a ingestão dos dados *csv.gz no 
# banco de dados SQLite churn.sqlite

# Carregando as bibliotecas
import os
import pandas as pd
import sqlalchemy # pip install sqlalchemy pymysql

# Definindo os caminhos do projeto
THIS_FILE = os.path.abspath(__file__)
WORK_DIR  = os.path.dirname(os.path.dirname(os.path.dirname(THIS_FILE)))
DATA_DIR  = os.path.join(WORK_DIR, 'data')

# Setando conexão e criando o banco de dados SQLITE
string_connection = 'sqlite:///{path}'.format(path=os.path.join(DATA_DIR, 'churn.sqlite'))
connection = sqlalchemy.create_engine(string_connection)

# Ingestão do primeiro csv: events.csv.gz
events_df = pd.read_csv(os.path.join(DATA_DIR, 'events.csv.gz'))
events_df = (
    events_df
    .assign(event_timestamp = lambda df: pd.to_datetime(df['event_timestamp']))
    .assign(product_id      = lambda df: df['product_id'].astype('Int64'))
    .assign(seller_id       = lambda df: df['product_id'].astype('Int64'))
)
events_df.to_sql('events', connection, index=False)

# Ingestão do segundo csv: products.csv.gz
products_df = pd.read_csv(os.path.join(DATA_DIR, 'products.csv.gz'))
products_df.to_sql('products', connection, index=False)    
