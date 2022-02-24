import os
import json
import requests
import aiohttp
import asyncio


class Crawler:
    def __init__(self, offline_token: str):
        self.token = self.get_refresh_token(offline_token)['access_token']
        self.api_url = 'https://api.access.redhat.com/management/v1'

        self.headers = {
            'Authorization': f'Bearer {self.token}',
            'accept': 'application/json'
        }

    def query_url(self, endpoint: str):
        return f'{self.api_url}{endpoint}'

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

    def get_subscriptions(self) -> list:
        limit = 50
        offset = 0
        count = 50

        while count >= limit:
            params = {
                'limit': limit,
                'offset': offset
            }
            r = requests.get(self.query_url('/subscriptions'),
                             headers=self.headers, params=params)
            r.raise_for_status()

            response = r.json()

            count = response['pagination']['count']
            offset += count
            yield response['body']

    async def get_content_sets(self, subscriptions: list):
        for subscription in subscriptions:
            subscription_number = subscription['subscriptionNumber']
            url = self.query_url(
                f'/subscriptions/{subscription_number}/contentSets')
            print(f'Querying {url}')
            async with self.session.get(url, headers=self.headers) as resp:
                # await resp.json()
                print(resp.status)


    async def crawl(self):
        async with aiohttp.ClientSession() as self.session:
            tasks = []
            for subscriptions in self.get_subscriptions():
                tasks.append(asyncio.ensure_future(self.get_content_sets(subscriptions)))

            print("All subscriptions crawled")
            await asyncio.gather(*tasks)


if __name__ == '__main__':
    token = os.getenv('API_TOKEN')

    crawler = Crawler(token)

    asyncio.run(crawler.crawl())
