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


# def generate_sql(question: str) -> str:

#     example_ques="""
#     Q. who is the dean of school of computer applications?
#     A. SELECT Name FROM authority_members WHERE Designation = 'Dean' AND Department = 'School of Computer Applications';

# """
    
#     prompt = f"""
# You are a MySQL expert assistant. Given the following database schema:

# {UNIVERSITY_SCHEMA}

# Write a syntactically correct SQL query to answer the following user question:
# "{question}"

# Only return the SQL query.
# Do not include explanations, markdown, or comments.
# Use correct column and table names from the schema above.
# """

#     data = {
#         "model": MODEL,
#         "messages": [
#             {"role": "system", "content": "You generate MySQL queries for a university database based on user questions. Only return SQL."},
#             {"role": "user", "content": prompt}
#         ]
#     }

#     headers = {
#         "Authorization": f"Bearer {GROQ_API_KEY}",
#         "Content-Type": "application/json"
#     }

#     try:
#         response = requests.post(GROQ_API_URL, headers=headers, json=data)
#         response.raise_for_status()
#         return response.json()['choices'][0]['message']['content'].strip()
#     except requests.exceptions.RequestException as e:
#         return f"Error: {e}"
# get_sql_query = generate_sql


# # backend/groq_api.py

# import os
# import requests
# from dotenv import load_dotenv

# load_dotenv()

# def get_sql_query(question):
#     system_prompt = "You are a university assistant who converts questions into MySQL queries. Only return the SQL query with no explanation."

#     payload = {
#         "messages": [
#             {"role": "system", "content": system_prompt},
#             {"role": "user", "content": question}
#         ],
#         "model": "mistral-saba-24b",
#     }

#     headers = {
#         "Authorization": f"Bearer {os.getenv('GROQ_API_KEY')}",
#         "Content-Type": "application/json"
#     }

#     response = requests.post("https://api.groq.com/openai/v1/chat/completions", json=payload, headers=headers)
#     response.raise_for_status()
#     return response.json()["choices"][0]["message"]["content"]
