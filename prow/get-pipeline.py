#! /usr/bin/env python3

import argparse
import requests
import re


API_BASE_URL = 'https://api.github.com'


class Requester:
    def __init__(self, org, repo):
        self.org = org
        self.repo = repo
        self.params = {
            'Accept': 'application/vnd.github.v3+json'
        }

    def get_commit(self, branch: str) -> str:
        """
        Gets the head commit of the given branch
        """
        url = f'{API_BASE_URL}/repos/{self.org}/{self.repo}/branches/{branch}'

        response = requests.get(url, params=self.params)
        response.raise_for_status()

        return response.json()['commit']['sha']

    def get_pr(self, commit: str) -> int:
        """
        Gets the PR number associated with a given commit
        """
        url = f'{API_BASE_URL}/repos/{self.org}/{self.repo}/commits/{commit}/pulls'

        response = requests.get(url, params=self.params)
        response.raise_for_status()

        prs = response.json()
        pr = prs[0]['url']
        if len(prs) != 1:
            print(f'Multiple PRs detected, using {pr}')

        return pr

    def get_pull_data(self, branch: str) -> dict:
        """
        Get PR data associated to a given branch
        """
        commit = self.get_commit(branch)
        url = self.get_pr(commit)

        response = requests.get(url)
        response.raise_for_status()

        return response.json()


def get_statuses(statuses_url: str) -> dict:
    response = requests.get(statuses_url)
    response.raise_for_status()

    return response.json()


def get_prow_params(statuses: list, stage: str) -> str:
    for status in statuses:
        if status['target_url'] is None:
            continue
        if stage == status['context'].split('/')[-1]:
            prow_components = status['target_url'].split('/')

            result = {
                'id': prow_components[-1],
                'job': prow_components[-2]
            }
            return result


def get_build_log(params: dict):
    response = requests.get('https://prow.ci.openshift.org/log', params=params)
    response.raise_for_status()

    return response.text


def find_registry(prow_log: str):
    target_line = re.compile(
        r'^.*\[\d+-\d+-\d+T\d+:\d+:\d+Z\] Using namespace https://console\.(\w+)\.ci\.openshift\.org/k8s/cluster/projects/([-\w]+)\W+$'
    )

    for log in prow_log.splitlines():
        farm = target_line.match(log)
        if farm is not None:
            return f'registry.{farm[1]}.ci.openshift.org/{farm[2]}/pipeline'


def main(requester: Requester, branch: str, stage: str):
    pr_data = requester.get_pull_data(branch)
    statuses_url = pr_data['statuses_url']
    statuses = get_statuses(statuses_url)
    prow_params = get_prow_params(statuses, stage)
    prow_log = get_build_log(prow_params)

    print(f'{find_registry(prow_log)}')


if __name__ == '__main__':
    description = 'Gets the pipeline used by prow for pulling images.'
    parser = argparse.ArgumentParser(description=description,
                                     formatter_class=argparse.RawTextHelpFormatter)

    parser.add_argument('organization', help='GH organization')
    parser.add_argument('repo', help='GH repository')
    parser.add_argument('branch', help='Branch we are searching for')
    parser.add_argument('stage', help='Stage to pipeline for', default='images')
    args = parser.parse_args()

    org = args.organization
    repo = args.repo
    branch = args.branch
    stage = args.stage

    requester = Requester(org, repo)

    main(requester, branch, stage)
