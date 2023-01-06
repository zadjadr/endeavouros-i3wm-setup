import argparse
import subprocess
import requests
import re

from bs4 import BeautifulSoup


parser = argparse.ArgumentParser(
                    prog = 'GpgImporter',
                    description = 'Import and update all keys from any keyserver',
                    epilog = 'Really simple and stupid')


parser.add_argument('-k', '--keyserver', help='Keyserver DNS without https:// or hkps:// prefix.')
parser.add_argument('-l', '--lookup', help='Any string to filter the GPG list by.')
parser.add_argument('-r', '--refresh', action='store_true')

options = parser.parse_args()


if options.keyserver is None:
    print('--keyserver must be provided')
    exit(1)


if options.refresh:
    subprocess.run(["gpg", "--batch", "--keyserver", f"hkps://{options.keyserver}", "--refresh-keys"], stdout=subprocess.PIPE)
    exit(0)

if options.lookup is None:
    print('--lookup must be provided')
    exit(1)

lookup_url = f"/pks/lookup?search={options.lookup}&fingerprint=on&op=index"
r = requests.get(f"https://{options.keyserver}{lookup_url}")

soup = BeautifulSoup(r.text)

all_keys = ""
all_fingerprints = []
num_keys = 0

gpg_sha_regex = re.compile(r"(?P<hash>\b[0-9a-fA-F]{8}\b).*Fingerprint=(?P<fingerprint>\b[0-9a-fA-F ]+\b)", re.DOTALL)

for link in soup.find_all('pre'):
    m = re.search(gpg_sha_regex, link.text)
    try:
        all_keys += m.group('hash') + " "
        all_fingerprints.append(m.group('fingerprint'))
        num_keys += 1
    except AttributeError:
        print(f'warn: could not find a key in this line: "{link.text.strip()}"')

print(f"Number of keys: {num_keys}")

subprocess.run(f"gpg --batch --keyserver hkps://{options.keyserver} --receive-keys {all_keys}", shell=True, check=True, stdout=subprocess.PIPE)

for f in all_fingerprints:
    subprocess.run(f"gpg --quick-sign-key '{f}'", shell=True, check=True, stdout=subprocess.PIPE)
