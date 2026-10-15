import pika

try:
    credentials = pika.PlainCredentials('admin', 'admin')
    parameters = pika.ConnectionParameters('localhost', 5673, '/', credentials)
    connection = pika.BlockingConnection(parameters)
    channel = connection.channel()
    print('RabbitMQ connected successfully on port 5673!')
    channel.queue_declare(queue='test_queue', durable=True)
    print('Test queue created successfully')
    connection.close()
except Exception as e:
    print(f'Error: {e}')
