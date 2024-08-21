#!/Users/valmiki/miniconda3/bin/python
"""
This script takes in a single argument: node + a 3-digit code like "003", "089" or "113" and edits the ~/.ssh/config file
and edits this section of the file:

Host omnode
  HostName nodeXXX
  ProxyJump om
  User ericjm

where XXX is some existing 3-digit code. We want to replace nodeXXX with the new node.
"""

import sys
import re

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: omnode nodeXXX")
        sys.exit(1)

    new_node = sys.argv[1]

    # Read in the file
    with open("/Users/valmiki/.ssh/config", "r") as f:
        lines = f.readlines()

    # Find the line with the 3-digit code in it
    for i, line in enumerate(lines):
        if re.search(r"omnode", line):
            break
    i += 1
    line = lines[i]

    # Replace the 3-digit code with the new one
    lines[i] = re.sub(r"HostName.*", f"HostName {new_node}", line)
    print(lines[i])

    # Write the file out again
    with open("/Users/valmiki/.ssh/config", "w") as f:
        f.writelines(lines)
