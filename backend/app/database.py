import mysql.connector
from mysql.connector import Error

def get_connection():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="1234",
            database="chatbot_university"
        )
        return connection  # Return the connection if successful
    except Error as e:
        print(f"Error: {e}")
        return None  # Return None if the connection fails
