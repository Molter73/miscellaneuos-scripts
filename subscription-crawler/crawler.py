import os
import json
import requests
import re

class Crawler:
    def __init__(self, offline_token: str):
        self.token = self.get_refresh_token(offline_token)['access_token']
        self.api_url = 'https://api.access.redhat.com/management/v1'
        self.crawled_repos = []
        self.exclude_patterns = [
            re.compile(r'^.*-devtools-.*$'),
            re.compile(r'^.*-debug-.*$'),
            re.compile(r'^codeready-builder-.*$')
        ]

        self.headers = {
            'Authorization': f'Bearer {self.token}',
            'accept': 'application/json'
        }

    def query_url(self, endpoint: str):
        return f'{self.api_url}{endpoint}'

    def exclude_repo(self, repo):
        for pattern in self.exclude_patterns:
            if pattern.match(repo):
                return True
        return False

    def get_refresh_token(self, offline_token: str) -> dict:
        url = 'https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token'
        data = {
            'grant_type': 'refresh_token',
            'client_id': 'rhsm-api',
            'refresh_token': f'{offline_token}'
        }

        r = requests.post(url, data=data, headers={
                          'accept': 'application/json'})
        r.raise_for_status()

        return r.json()

    def paginate_request(self, endpoint: str):
        limit = 100
        offset = 0
        count = 100

        while count >= limit:
            params = {
                'limit': limit,
                'offset': offset
            }
            resp = requests.get(self.query_url(endpoint),
                                headers=self.headers, params=params)

            if not resp.ok:
                print(resp)
                break

            response = resp.json()

            count = response['pagination']['count']
            offset += count
            print(f'################ Entries crawled: {offset}')
            yield response['body']

    def get_subscriptions(self) -> list:
        print('subscriptions')
        return self.paginate_request('/subscriptions')

    def get_content_sets(self, subscriptions: list):
        print('content sets')
        for subscription in subscriptions:
            subscription_number = subscription['subscriptionNumber']
            return self.paginate_request(f'/subscriptions/{subscription_number}/contentSets')

    def get_packages(self, content_sets):
        print('packages')
        for content_set in content_sets:
            repo = content_set["label"]
            print(f'################ {repo} ################')
            if repo in self.crawled_repos:
                print(f'Skipping duplicated repository - {repo}')
                continue

            self.crawled_repos.append(repo)

            if self.exclude_repo(repo):
                print(f'Skipping {repo}')
                continue

            if 'arch' not in content_set:
                print(f'No arch - Skipping {content_set}')
                continue

            if content_set['arch'] != 'x86_64':
                print(f'Unwanted arch - Skipping {content_set}')
                continue

            for packages in self.paginate_request(f'/packages/cset/{repo}/arch/x86_64'):
                self.filter_kernel_headers(packages)

    def filter_kernel_headers(self, packages):
        for pkg in packages:
            if pkg['name'] != 'kernel-devel':
                continue

            kernel = f'kernel-devel-{pkg["version"]}-{pkg["release"]}.x86_64'
            print(kernel)

    def crawl(self):
        for subscriptions in self.get_subscriptions():
            for content_sets in self.get_content_sets(subscriptions):
                self.get_packages(content_sets)

        print("All subscriptions crawled")


if __name__ == '__main__':
    # Go to https://access.redhat.com/management/api to get a token
    # and supply it as an environment variable.
    token = os.getenv('API_TOKEN')

    crawler = Crawler(token)

    crawler.crawl()
