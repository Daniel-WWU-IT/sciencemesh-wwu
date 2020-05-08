#!/usr/bin/python3
import os, requests, tarfile, filecmp, shutil


# GOCDB base version
GOCDB_VERSION = "5.7.5"


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


def fetch_gocdb(dest_dir):
    TextOutput.print(f"Downloading GOCDB version {GOCDB_VERSION}:")
    filename = f"{GOCDB_VERSION}.tar.gz"
    url = f"https://github.com/GOCDB/gocdb/archive/{filename}"
    destfile = f"{dest_dir}/{filename}"
    TextOutput.print(f"\t$b>File:<$ {url}")
    TextOutput.print(f"\t$b>Destination<$: {destfile}")

    # Download the GOCDB archive
    try:
        data = requests.get(url)
        with open(destfile, "wb") as f:
            f.write(data.content)
    except Exception as e:
        TextOutput.print(f"$red>Failed:<$ {str(e)}")
        exit(1)

    TextOutput.print("$green>Done!<$")
    return destfile


def extract_gocdb(archive_file, dest_dir):
    TextOutput.print("Extracting downloaded GOCDB archive:")
    TextOutput.print(f"\t$b>File:<$ {archive_file}")
    TextOutput.print(f"\t$b>Destination:<$ {dest_dir}")

    # Extract the archive contents to the output directory
    try:
        tar = tarfile.open(archive_file)
        tar.extractall(dest_dir)
    except Exception as e:
        TextOutput.print(f"$red>Failed:<$ {str(e)}")
        exit(1)

    TextOutput.print("$green>Done!<$")
    return f"{dest_dir}/gocdb-{GOCDB_VERSION}"


def gather_differing_files(source_dir, archive_dir):
    TextOutput.print("Gathering differing files:")
    TextOutput.print(f"\t$b>Sources:<$ {source_dir}")
    TextOutput.print(f"\t$b>Originals:<$ {archive_dir}")

    # Get relative filenames of all source files
    filelist = []
    for root, dirs, files in os.walk(source_dir):
        for filename in files:
            filelist.append(os.path.relpath(os.path.join(root, filename), source_dir))

    # Compare all files in the filelist
    matches, mismatches, errors = filecmp.cmpfiles(source_dir, archive_dir, filelist, shallow=False)

    TextOutput.print(f"$green>Done!<$ {len(mismatches)} modified files, {len(errors)} new files")
    return mismatches, errors


def copy_differing_files(files, source_dir, target_dir):
    TextOutput.print(f"Copying {len(files)} new and modified files:")

    # Remove all previously copied files
    shutil.rmtree(target_dir)

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
    source_dir = "/home/tak/proj/sciencemesh-wwu/gocdb-container/webserver/html.dev/gocdb"
    # Destination directory for download and extraction
    dest_dir = "/tmp"
    # Target directory for all modified and new files
    target_dir = "/home/tak/proj/sciencemesh-wwu/gocdb-container/webserver/html/gocdb"

    # Download the archive...
    gocdb_archive = fetch_gocdb(dest_dir)
    TextOutput.print("")
    # ... and extract it
    gocdb_sources = extract_gocdb(gocdb_archive, dest_dir)
    TextOutput.print("")

    # Gather all differing and new files
    differing_files, new_files = gather_differing_files(source_dir, gocdb_sources)
    TextOutput.print("")

    # Copy all modified and new files
    copy_differing_files(differing_files + new_files, source_dir, target_dir)

    # Clean up downloaded files
    os.remove(gocdb_archive)
    shutil.rmtree(gocdb_sources)
