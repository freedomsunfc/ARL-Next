from pymongo import MongoClient

client = MongoClient('mongodb://admin:admin@127.0.0.1:27018/?authSource=admin', serverSelectionTimeoutMS=5000)
try:
    result = client.admin.command('listDatabases')
    print('Authenticated connection successful!')
    print('Databases:', [db['name'] for db in result['databases']])
except Exception as e:
    print(f'Error: {e}')
