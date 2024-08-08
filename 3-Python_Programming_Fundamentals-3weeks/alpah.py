import cv2
import shutil
import os

alphabet_dict = {
    'A': 1, 'B': 2, 'C': 3, 'D': 4, 'E': 5, 'F': 6, 'G': 7, 'H': 8, 'I': 9,
    'J': 10, 'K': 11, 'L': 12, 'M': 13, 'N': 14, 'O': 15, 'P': 16, 'Q': 17,
    'R': 18, 'S': 19, 'T': 20, 'U': 21, 'V': 22, 'W': 23, 'X': 24, 'Y': 25, 'Z': 26,
    '.':27, ' ':28 
}

# Input word
word = input ("enter any text: ")  # Replace with the desired word

# Convert the word to uppercase to match the dictionary keys
word = word.upper()

# Check if all characters are in the alphabet_dict
all_chars_valid = True
for char in word:
    if char not in alphabet_dict:
        all_chars_valid = False
        break

if all_chars_valid:
    
    #Split the word into characters and find the corresponding numbers
    numbers = []
    for char in word:
        numbers.append(alphabet_dict[char])

    # Define the paths

    # it was ""
    source_folder = input(r"Enter source of the alphapet file: ")
    destination_folder = input (r"Enter the folder of results: ")

    # Process images corresponding to the numbers
    for index, number in enumerate(numbers):
        image_name = f"{number}.jpg" 
        source_image_path = os.path.join(source_folder, image_name)
        new_image_name = f"{index + 1}.jpg"
        destination_image_path = os.path.join(destination_folder, new_image_name)
        shutil.copy(source_image_path, destination_image_path)

    print ("Go check the result file ;), make sure before running the program again to delete the result first from the folder that contains the results ><!!LO ")

else:
    print("These characters aren't allowed.")