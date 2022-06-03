#! /usr/bin/env python3

import argparse
import requests
import re


def get_pull_data(pr: str) -> dict():
    url = f'https://api.github.com/repos/openshift/release/pulls/{pr}'

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


def main(pr: str, stage: str):
    pr_data = get_pull_data(pr)
    statuses_url = pr_data['statuses_url']
    statuses = get_statuses(statuses_url)
    prow_params = get_prow_params(statuses, stage)
    prow_log = get_build_log(prow_params)

    print(f'{find_registry(prow_log)}')


if __name__ == '__main__':
    description = 'Gets the pipeline used by prow for pulling images.'
    parser = argparse.ArgumentParser(description=description,
                                     formatter_class=argparse.RawTextHelpFormatter)

    parser.add_argument('pr', help='PR number to find pipeline from', default='29021')
    parser.add_argument('stage', help='Stage to pipeline for', default='images')
    args = parser.parse_args()

    main(args.pr, args.stage)
