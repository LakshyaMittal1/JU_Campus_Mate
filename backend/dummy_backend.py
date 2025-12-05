""" 
# dummy_backend.py

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

import time

app = FastAPI()

# CORS (allows Flutter frontend to call the backend)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/askques")
async def ask_question(data: dict):
    question = data.get("question", "")
    # You can customize this static logic

    # introducing a delay to mimic the thinking and searching time taken by the backend
    time.sleep(3)
    return {"summary": f"Dummy response for: {question}"}



# http://localhost:5000/docs#/default/ask_question_askques_post

# To run the FastAPI server, use the following command (first reach to the directory where this file is located):
# python -m uvicorn dummy_backend:app --host 0.0.0.0 --port 5000 """

""" from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from gemini_api import generate_sql_from_question, generate_nl_summary_from_sql_result
from db import execute_sql

app = FastAPI()

# CORS for Flutter
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/askques")
async def ask_question(data: dict):
    question = data.get("question", "")

    # Step 1 — Generate SQL
    generated_sql = generate_sql_from_question(question)
    print("Generated SQL:", generated_sql)

    # Step 2 — Execute SQL
    sql_result = execute_sql(generated_sql)
    print("SQL Result:", sql_result)

    # Step 3 — Convert SQL result → natural language
    summary = generate_nl_summary_from_sql_result(sql_result)

    return {
        "query": generated_sql,
        "result": sql_result,
        "summary": summary
    }
 """


from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from gemini_api import generate_sql_from_question, generate_nl_summary_from_sql_result
from db import execute_sql

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# ---------------------------------------------------
# MAIN COMBINED ENDPOINT
# ---------------------------------------------------
@app.post("/askques")
async def ask_question(data: dict):
    question = data.get("question", "")

    generated_sql = generate_sql_from_question(question)
    print("Generated SQL:", generated_sql)

    sql_result = execute_sql(generated_sql)
    print("SQL Result:", sql_result)

    summary = generate_nl_summary_from_sql_result(sql_result)

    return {
        "query": generated_sql,
        "result": sql_result,
        "summary": summary
    }

# ---------------------------------------------------
# DEBUGGING ENDPOINTS
# ---------------------------------------------------

# 1. Only generate SQL
@app.post("/gen-sql")
async def gen_sql(data: dict):
    question = data.get("question", "")
    sql = generate_sql_from_question(question)
    return {"generated_sql": sql}

# 2. Only execute SQL
@app.post("/run-sql")
async def run_sql(data: dict):
    query = data.get("query", "")
    result = execute_sql(query)
    return {"result": result}

# 3. Only summarize SQL result
@app.post("/summarize")
async def summarize(data: dict):
    sql_result = data.get("sql_result", [])
    summary = generate_nl_summary_from_sql_result(sql_result)
    return {"summary": summary}
