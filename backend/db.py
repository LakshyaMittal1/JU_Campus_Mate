import mysql.connector
import os
from dotenv import load_dotenv
from datetime import date, datetime
load_dotenv()
def execute_sql(query):
    conn = mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME"),
        port=int(os.getenv("DB_PORT"))
    )
    cursor = conn.cursor(dictionary=True)
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    for row in result:
        for key, value in row.items():
            if isinstance(value, (date, datetime)):
                row[key] = value.isoformat()  # Converts to 'YYYY-MM-DD'

    #return result
    return result