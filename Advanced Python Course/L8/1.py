import asyncio
import json
from aiohttp import ClientSession

from private import API_KEY

async def collect_data(url, session, headers=None):
    async with session.get(url, headers=headers) as response:
        return await response.text()

async def get_data_api(session, api_key):
    url = "https://moviesdatabase.p.rapidapi.com/actors/random"
    headers = {
        "X-RapidAPI-Key": f"{api_key}",
        "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
    }
    return await collect_data(url, session, headers=headers)

async def get_data(session):
    url = "https://api.thecatapi.com/v1/images/search?limit=10"
    return await collect_data(url, session, None)

async def main():
    async with ClientSession() as session:
        tasks = [
            get_data_api(session, API_KEY),
            get_data(session)
        ]
        data1, data2 = await asyncio.gather(*tasks)

        data_json1 = json.loads(data1)
        data_json2 = json.loads(data2)

        print("Dane z API 2:", data_json1)
        print("Dane:", data_json2)

if __name__ == "__main__":
    asyncio.run(main())
