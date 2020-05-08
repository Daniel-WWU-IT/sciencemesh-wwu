#!/usr/bin/python3
import os, shutil

class TextOutput:
    PURPLE = '\033[95m'
    CYAN = '\033[96m'
    DARKCYAN = '\033[36m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    END = '\033[0m'

    @staticmethod
    def print(text, add_newline=True):
        text = text.replace("$purple>", TextOutput.PURPLE)
        text = text.replace("$cyan>", TextOutput.CYAN)
        text = text.replace("$darkcyan>", TextOutput.DARKCYAN)
        text = text.replace("$blue>", TextOutput.BLUE)
        text = text.replace("$green>", TextOutput.GREEN)
        text = text.replace("$yellow>", TextOutput.YELLOW)
        text = text.replace("$red>", TextOutput.RED)
        text = text.replace("$b>", TextOutput.BOLD)
        text = text.replace("$u>", TextOutput.UNDERLINE)
        text = text.replace("<$", TextOutput.END)

        if add_newline:
            print(text)
        else:
            print(text, end="")


def gather_differing_files(source_dir):
    TextOutput.print("Gathering differing files:")
    TextOutput.print(f"\t$b>Sources:<$ {source_dir}")

    # Get relative filenames of all source files
    filelist = []
    for root, dirs, files in os.walk(source_dir):
        for filename in files:
            filelist.append(os.path.relpath(os.path.join(root, filename), source_dir))

    TextOutput.print(f"$green>Done!<$ {len(filelist)} modified or new files")
    return filelist


def copy_differing_files(files, source_dir, target_dir):
    TextOutput.print(f"Copying {len(files)} new and modified files:")

    # Copy each modified or new file to the target directory, creating any missing folders
    for filename in files:
        source_file = os.path.join(source_dir, filename)
        target_file = os.path.join(target_dir, filename)
        TextOutput.print(f"\t{filename}")

        try:
            os.makedirs(os.path.dirname(target_file), exist_ok=True)
            shutil.copy2(source_file, target_file)
        except Exception as e:
            TextOutput.print(f"$red>Failed:<$ {str(e)}")
            exit(1)

    TextOutput.print("$green>Done!<$")


if __name__ == "__main__":
    # Directory where the modified GOCDB files are located
    source_dir = "/home/tak/proj/sciencemesh-wwu/gocdb-container/webserver/html/gocdb"
    # Target directory for all modified and new files
    target_dir = "/home/tak/proj/sciencemesh-wwu/gocdb-container/webserver/html.dev/gocdb"

    # Gather all differing and new files
    differing_files = gather_differing_files(source_dir)
    TextOutput.print("")

    # Copy all modified and new files
    copy_differing_files(differing_files, source_dir, target_dir)
