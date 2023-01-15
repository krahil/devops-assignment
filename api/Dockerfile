FROM python:3
ENV APP /app
RUN mkdir $APP
WORKDIR $APP
EXPOSE 5000
COPY requirements.txt .
#RUN useradd --no-create-home nginx
RUN pip install -r requirements.txt
COPY . .
CMD gunicorn app:app -w 2 -b 0.0.0.0:5000 -t 30
