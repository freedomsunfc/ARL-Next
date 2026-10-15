from pymongo import MongoClient

client = MongoClient('mongodb://127.0.0.1:27018', serverSelectionTimeoutMS=5000)
try:
    client.admin.command('createUser', 'admin', pwd='admin', roles=[{'role': 'root', 'db': 'admin'}])
    print('Admin user created successfully')
    result = client.admin.command('listDatabases')
    print('Databases:', [db['name'] for db in result['databases']])
except Exception as e:
    print(f'Error: {e}')
