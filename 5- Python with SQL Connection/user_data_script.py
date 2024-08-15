import pyodbc
import json
import os

# Part 1: Connect to SQL Server
def connect_to_db():
    conn_str = (
        r'DRIVER={SQL Server};'
        r'SERVER=localhost\SQLEXPRESS;'
        r'DATABASE=user_database;'
        r'Trusted_Connection=yes;'
    )
    try:
        conn = pyodbc.connect(conn_str)
        print("Connection successful.")
        return conn
    except Exception as e:
        print(f"Error connecting to SQL Server: {e}")
        return None

# Part 2: Load Data from File
def load_data_from_file(filename):
    if os.path.exists(filename) and os.path.getsize(filename) > 0:
        with open(filename, 'r') as file:
            user_data = json.load(file)
        return user_data
    else:
        print(f"No data found in {filename}.")
        return None

# Part 3: Insert Data into SQL Server
def insert_data_to_db(conn, user_data):
    cursor = conn.cursor()
    for user_id, details in user_data.items():
        first_name = details["first_name"]
        last_name = details["last_name"]
        age = details["age"]
        gender = details["gender"]
        year_of_birth = details["year_of_birth"]
        
        try:
            cursor.execute("""
                INSERT INTO users (user_id, first_name, last_name, age, gender, year_of_birth)
                VALUES (?, ?, ?, ?, ?, ?)
            """, user_id, first_name, last_name, age, gender, year_of_birth)
            print(f"Data for User ID {user_id} inserted successfully.")
        except Exception as e:
            print(f"Error inserting data for User ID {user_id}: {e}")
    
    conn.commit()

# Part 4: Main Execution
def main():
    path = r'D:\DEPI Data Engineer\0_projects\User_Input_SQL'
    filename = os.path.join(path, 'user_data.txt')
    
    conn = connect_to_db()
    if conn:
        user_data = load_data_from_file(filename)
        if user_data:
            insert_data_to_db(conn, user_data)
        conn.close()

if __name__ == "__main__":
    main()
