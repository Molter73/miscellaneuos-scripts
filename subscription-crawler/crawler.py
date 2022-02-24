import os
import requests
import json


def get_refresh_token(offline_token: str) -> dict:
    # -d client_id=rhsm-api -d refresh_token=$offline_toke
    url = 'https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token'
    data = {
        'grant_type': 'refresh_token',
        'client_id': 'rhsm-api',
        'refresh_token': f'{offline_token}'
    }
    headers = {'accept': 'application/json'}

    r = requests.post(url, data=data, headers=headers)

    r.raise_for_status()

    return r.json()


def get_subscriptions(token: str) -> list:
    limit = 50
    offset = 0
    count = 50
    result = []

    url = 'https://api.access.redhat.com/management/v1/subscriptions'
    headers = {
        'Authorization': f'Bearer {token}',
        'accept': 'application/json'
    }

    while count >= limit:
        params = {
            'limit': limit,
            'offset': offset
        }
        r = requests.get(url, headers=headers, params=params)
        r.raise_for_status()

        response = r.json()

        count = response['pagination']['count']
        offset += count
        yield response['body']


if __name__ == '__main__':
    token = os.getenv('API_TOKEN')

    response = get_refresh_token(token)

    if 'access_token' not in response:
        print(f'Unable to retrieve access token: {response}')
        exit(1)

    token = response['access_token']

    for subscriptions in get_subscriptions(token):
        print(json.dumps(subscriptions))
