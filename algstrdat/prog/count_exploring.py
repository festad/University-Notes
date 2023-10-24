def count_exploring(file1, file2):
    """Counting the occurrences of the word "Exploring"
    inside two files and returning the result."""
    for file in [file1, file2]:
        count = 0   
        with open(file, "r") as f:
            for line in f:
                for word in line.split():
                    if word == "Exploring":
                        count += 1
        print("File", file, "contains", count, "occurrences of the word Exploring.")
    # return count



if __name__ == "__main__":
    # counting the occurrences of the
    # word "Exploring" inside two files
    # and printing the result
    count_exploring("output_sudoku_64_breaking.md", "output_sudoku_64_no_breaking.md")



