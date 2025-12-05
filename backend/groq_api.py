import requests
import os
from dotenv import load_dotenv
import json
load_dotenv()

OLLAMA_BASE_URL = "http://localhost:11434/api/generate"
MODEL_NAME = "university-sql-bot:latest" 

def generate_sql_from_question(question: str) -> str:
    prompt = (
        "You are a helpful assistant that converts natural language questions into MySQL query according the database structure .\n\n"
        f"Question: {question}\n"
        "SQL:"
    )
    response = requests.post(
        OLLAMA_BASE_URL,
        json={
            "model": MODEL_NAME,
            "prompt": prompt,
            "stream": False
        }
    )
    
    if response.status_code == 200:
        return response.json()["response"].strip()
    else:
        raise Exception(f"Error: {response.status_code}, {response.text}")




#OLLAMA_BASE_URL = "http://localhost:11434/api/generate"
MODEL_NAME1 = "sql-response:latest"

def generate_nl_summary_from_sql_result(sql_result: list[dict]) -> str:
    result_str = json.dumps(sql_result, indent=2)
    prompt = (
        "You are an expert natural language answer generator. Given an SQL query result, you must generate a simple and precise natural response of that result in English.\n\n"
        f"SQL Result:\n{result_str}\n"
        "Summary:"
    )

    response = requests.post(
        OLLAMA_BASE_URL,
        json={
            "model": MODEL_NAME1,
            "prompt": prompt,
            "temperature": 0.0,
            "stream": False
        }
    )

    if response.status_code == 200:
        return response.json()["response"].strip()
    else:
        raise Exception(f"Error: {response.status_code}, {response.text}")


