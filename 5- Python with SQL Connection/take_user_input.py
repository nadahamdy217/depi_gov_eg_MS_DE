import os
import json

# Part 1: File Handling and Data Structure Initialization

# 1. File Existence Check
path = r'D:\DEPI Data Engineer\0_projects\User_Input_SQL'
filename = os.path.join(path, 'user_data.txt')

if not os.path.exists(filename):
    with open(filename, 'w') as file:
        pass  # Create the file if it doesn't exist

# 2. Load Existing Data
user_data = {}
if os.path.getsize(filename) > 0:  # Check if the file is not empty
    with open(filename, 'r') as file:
        user_data = json.load(file)

# Part 2: User Input and Validation

# 3. Collect User Data
def get_user_input():
    user_id = input("Enter User ID: ")
    first_name = input("Enter First Name: ")
    last_name = input("Enter Last Name: ")
    age = input("Enter Age: ")
    gender = input("Enter Gender (M/F): ").upper()
    year_of_birth = input("Enter Year of Birth: ")
    return user_id, first_name, last_name, age, gender, year_of_birth

# 4. Input Validation
def validate_input(user_id, first_name, last_name, age, gender, year_of_birth, user_data):
    current_year = 2024
    calculated_age = current_year - int(year_of_birth)
    
    if not user_id.isalnum() or user_id in user_data:
        return False, "Invalid User ID or User ID already exists."
    if not first_name.isalpha() or not last_name.isalpha():
        return False, "Names must contain only alphabetic characters."
    if not age.isdigit() or int(age) <= 0 or int(age) != calculated_age:
        return False, f"Age must be a positive integer and match the year of birth. Expected age: {calculated_age}"
    if gender not in ["M", "F"]:
        return False, "Invalid gender."
    if not year_of_birth.isdigit() or len(year_of_birth) != 4 or calculated_age < 18:
        return False, "Year of birth must be a four-digit number, and the user must be at least 18 years old."
    return True, "Input is valid."

# 5. User ID Duplication Check
def check_duplicate_user_id(user_id, user_data):
    if user_id in user_data:
        return True, "ID already exists. Cannot enter the data."
    return False, "ID is unique."

# Part 3: Data Storage and Persistence

# 6. Data Storage
def store_data(user_id, first_name, last_name, age, gender, year_of_birth, user_data):
    user_data[user_id] = {
        "first_name": first_name,
        "last_name": last_name,
        "age": int(age),
        "gender": gender,
        "year_of_birth": int(year_of_birth)
    }

# 7. Save Data to File
def save_data_to_file(user_data, filename):
    with open(filename, 'w') as file:
        json.dump(user_data, file, indent=4)

# Part 4: Data Retrieval and Display

# 8. Data Retrieval
def retrieve_data(user_data, user_id=None):
    if user_id:
        return user_data.get(user_id, "User not found.")
    else:
        return user_data

# 9. User-Friendly Output
def display_data(data):
    if isinstance(data, dict):
        for user_id, details in data.items():
            print(f"User ID: {user_id}")
            for key, value in details.items():
                print(f"  {key}: {value}")
    else:
        print(data)

# Part 5: Error Handling and Program Control

# 10. Main Function and Error Handling
try:
    def main():
        while True:
            option = input("Choose an option: [1] Enter new data, [2] Retrieve data, [3] Exit: ")
            if option == "1":
                user_id, first_name, last_name, age, gender, year_of_birth = get_user_input()
                valid, msg = validate_input(user_id, first_name, last_name, age, gender, year_of_birth, user_data)
                if valid:
                    store_data(user_id, first_name, last_name, age, gender, year_of_birth, user_data)
                    save_data_to_file(user_data, filename)
                    print("Data saved successfully.")
                else:
                    print(msg)
            elif option == "2":
                user_id = input("Enter User ID (or press Enter to view all users): ")
                data = retrieve_data(user_data, user_id)
                display_data(data)
            elif option == "3":
                print("Exiting program...")
                break
            else:
                print("Invalid option.")

    if __name__ == "__main__":
        main()

except Exception as e:
    print(f"An error occurred: {e}")
