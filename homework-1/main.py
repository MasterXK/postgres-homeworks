"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2


conn = psycopg2.connect(
    host="localhost",
    database="mydatabase",
    user="postgres",
    password="12345"
)
