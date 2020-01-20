import os
import sys
from subprocess import call

from github import Github

ORG_NAME = 'amount'
REPO_NAME = 'avant-basic'
CREDENTIAL_FILE = os.path.join('/Users', 'michaelbarton', '.avant')

def run(pull_number):
  pr = get_pull(pull_number)
  checkout_branch(pr)
  files = [p.filename for p in pr.get_files()]
  call(['vim', *files])

def checkout_branch(pr):
  branch = pr.head.label.split(':')[1]
  subcommand = ['checkout', branch]
  call(['git', 'pull'])
  call(['git', *subcommand])

def get_github_token():
  with open(CREDENTIAL_FILE, 'r') as f:
    for line in f:
      if line.find('github') != -1:
        return line.split(' ')[1].strip()

def get_pull(number):
  token = get_github_token()
  g = Github(token)
  for o in g.get_user().get_orgs():
    if o.login == ORG_NAME:
      for i in o.get_repos():
        if i.full_name == ORG_NAME + '/' + REPO_NAME:
          return i.get_pull(number)
  return None


if __name__ == '__main__':
  try:
    if len(sys.argv) != 2:
      print('Error: missing pull number.\nUsage: python files.py <pull_number>')
    num = int(sys.argv[1])
    run(num)
  except Exception as e:
    print(e)
