#!/usr/bin/python3

import os
import subprocess

from latch import Latch


# CONSTANTS
LATCH_APP_ID = os.getenv("LATCH_APP_ID")
LATCH_SECRET = os.getenv("LATCH_SECRET")
ACCOUNT_ID = ""
READ_ONLY_OPERATION_ID = ""
EDITION_OPERATION_ID = ""
ADMINISTRATION_OPERATION_ID = ""

banner = """
 ▄█     █▄     ▄███████▄   ▄▄▄▄███▄▄▄▄  
███     ███   ███    ███ ▄██▀▀▀███▀▀▀██▄
███     ███   ███    ███ ███   ███   ███
███     ███   ███    ███ ███   ███   ███
███     ███ ▀█████████▀  ███   ███   ███
███     ███   ███        ███   ███   ███
███ ▄█▄ ███   ███        ███   ███   ███
 ▀███▀███▀   ▄████▀       ▀█   ███   █▀ 
"""


# Functions
def pair_with_latch(token):
    print("Pairing with Latch...")
    try:
        latch_instance = Latch(LATCH_APP_ID, LATCH_SECRET)
        response = latch_instance.pair(token)

        if response.get_error():
            raise

        print("Latch paired successfully\n")

        response_data = response.get_data()
        return response_data["accountId"]
    except:
        print("[!] Error pairing Latch. Exiting...")
        exit(1)


def create_latch_operation(operation_name):
    print(f"Creating '{operation_name}' operation...")
    try:
        latch_instance = Latch(LATCH_APP_ID, LATCH_SECRET)
        response = latch_instance.create_operation(LATCH_APP_ID, operation_name, "DISABLED", "DISABLED")

        if response.get_error():
            raise

        print(f"'{operation_name}' operation created successfully\n")

        response_data = response.get_data()
        return response_data["operationId"]
    except:
        print(f"[!] Error creating '{operation_name}' operation. Exiting...")
        exit(1)


# Workflow
print(
    "\033[96m" + banner + "\nWordpress in Paranoid Mode with Latch\nChema Alonso & Pablo González",
)

# Reset print() color
print("\033[0m")

# Pair with Latch
print(30 * "-" + "\nStep 1: Pairing with Latch\n" + 30 * "-")
token = input("Enter your Latch token: ")
ACCOUNT_ID = pair_with_latch(token)

# Create Latch operations
print(30 * "-" + "\nStep 2: Create operations\n" + 30 * "-")
READ_ONLY_OPERATION_ID = create_latch_operation("ReadOnly")
EDITION_OPERATION_ID = create_latch_operation("Edition")
ADMINISTRATION_OPERATION_ID = create_latch_operation("Administration")

# Generate triggers file
print(30 * "-" + "\nStep 3: Generate triggers file\n" + 30 * "-")
print("Generating 'triggers.sql' file from 'triggers_template.sql'...")
try:
    with open("triggers_template.sql", "r") as file:
        triggers = file.read()

    triggers = triggers.replace("{{LATCH_APP_ID}}", LATCH_APP_ID)
    triggers = triggers.replace("{{LATCH_SECRET}}", LATCH_SECRET)
    triggers = triggers.replace("{{ACCOUNT_ID}}", ACCOUNT_ID)
    triggers = triggers.replace("{{READ_ONLY_OPERATION_ID}}", READ_ONLY_OPERATION_ID)
    triggers = triggers.replace("{{EDITION_OPERATION_ID}}", EDITION_OPERATION_ID)
    triggers = triggers.replace("{{ADMINISTRATION_OPERATION_ID}}", ADMINISTRATION_OPERATION_ID)

    with open("triggers.sql", "w") as file:
        file.write(triggers)

    print("Triggers file created successfully!\n")
except:
    print("[!] Error creating triggers file. Exiting...")
    exit(1)

# Create triggers
print(30 * "-" + "\nStep 4: Create triggers\n" + 30 * "-")
print("Creating triggers...")
try:
    subprocess.run(["psql", "-U", "postgres", "-d", "postgres", "-f", "triggers.sql"])
    print("Triggers created successfully!\n")
except:
    print("[!] Error creating triggers. Exiting...")
    exit(1)
