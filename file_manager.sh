#!/bin/bash

#main menu
show_menu(){
    echo "FILES & DIRECTORY MANAGER"
    echo "1. List files in current directory"
    echo "2. Create new directory"
    echo "3. Create a file"
    echo "4. Delete a file"
    echo "5. Rename a file"
    echo "6. Search for a file"
    echo "7. Count files and directories"
    echo "8. View Permissions"
    echo "9. Copy file to different directory"
    echo "10. Exit"
}

# while loop
while true; do
    show_menu
    read -p "Select operation (1-10): " choice

    case $choice in
        1)
            echo "List of files :"
            ls -lh
            ;;
        2)
            read -p "Enter name for new directory: " dirname
            if [ -d "$dirname" ]; then
                echo "Error: Directory '$dirname' already exists."
            else
                mkdir "$dirname" && echo "Success: Directory '$dirname' created."
            fi
            ;;
        3)
            read -p "Enter name for new file: " filename
            touch "$filename" && echo "Success: File '$filename' created."
            ;;
        4)
            read -p "Enter filename to delete: " delfile
            if [ -f "$delfile" ]; then
                read -p "Are you sure you want to delete '$delfile'? (y/n): " confirm
                if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                    rm "$delfile" && echo "Success: File deleted."
                else
                    echo "Action cancelled."
                fi
            else
                echo "Error: File '$delfile' does not exist."
            fi
            ;;
        5)
            read -p "Enter existing filename: " oldname
            if [ -e "$oldname" ]; then
                read -p "Enter new name: " newname
                mv "$oldname" "$newname" && echo "Success: Renamed to '$newname'."
            else
                echo "Error: '$oldname' not found."
            fi
            ;;
        6)
            read -p "Enter filename pattern to search: " pattern
            echo "Search results:"
            find . -maxdepth 1 -name "$pattern"
            ;;
        7)
            
            files=$(find . -maxdepth 1 -type f | wc -l)
            dirs=$(find . -maxdepth 1 -type d -not -path "." | wc -l)
            echo "Files: $files"
            echo "Directories: $dirs"
            ;;
        8) 
            read -p "Enter filename to view permissions: " permfile
            if [ -e "$permfile" ]; then
                ls -ld "$permfile" | awk '{print "Permissions: " $1}'
            else
                echo "Error: File not found."
            fi
            ;;
        9)
            read -p "Enter source file: " src
            if [ -f "$src" ]; then
                read -p "Enter destination name/path: " dest
                cp "$src" "$dest" && echo "Success: File copied to '$dest'."
            else
                echo "Error: Source file does not exist."
            fi
            ;;
        10)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
    echo "" 
done