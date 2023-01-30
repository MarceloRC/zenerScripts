import requests
from decouple import config
import pymongo

mongoClient = pymongo.MongoClient(config('MONGO_URL'))
db = mongoClient.ticketMeister
collection = db.tickets
requesting = []
API_TOKEN = config('TOMTICKET_API_TOKEN')

print('Deleting database')
col = db.tickets
col.drop()

baseURL = 'https://api.tomticket.com/chamados/'

response = requests.get(baseURL+API_TOKEN+'/1')
totalTickets = response.json()['total_itens']
pages = (totalTickets // 50)
if (totalTickets % 50) > 0:
    pages = pages+2

print(pages)

for page in range(1, pages):
    print("Getting page #"+str(page))
    response = requests.get(baseURL+API_TOKEN+"/" + str(page))
    allTickets = response.json()['data']
    for ticket in allTickets:
        ticket['CreatedAt'] = datetime.strptime(ticket['Data Criacao'] , '%Y/%m/%dT%H:%M:%SZ0300')
    x = collection.insert_many(allTickets)
    print(x.inserted_ids)
