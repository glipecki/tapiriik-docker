FROM python:3

RUN git clone https://github.com/cpfair/tapiriik.git

WORKDIR /tapiriik
RUN pip3 install -r requirements.txt
RUN cp tapiriik/local_settings.py.example tapiriik/local_settings.py
RUN python3 credentialstore_keygen.py >> tapiriik/local_settings.py

EXPOSE 8000

RUN echo MONGO_HOST = \"mongo\" >> tapiriik/local_settings.py
RUN echo REDIS_HOST = \"redis\" >> tapiriik/local_settings.py
RUN echo RABBITMQ_BROKER_URL = \"amqp://guest@rabbitmq//\" >> tapiriik/local_settings.py

CMD python3 manage.py runserver 0.0.0.0:8000
