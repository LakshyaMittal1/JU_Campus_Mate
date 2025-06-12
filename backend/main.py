from fastapi import FastAPI, HTTPException
from groq_api import generate_sql_from_question, generate_nl_summary_from_sql_result
from db import execute_sql
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

class ApiData(BaseModel):
    question: str
origins = [
    "http://localhost:59189"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # or ["*"] to allow all (not recommended for prod)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {"message": "University chatbot is running!"}


@app.post("/ask")
def ask_question(question: str):
    try:
        print("Received question:", question)  # Debug
        sql = generate_sql_from_question(question)
        print("Generated SQL:", sql)  # Debug
        result = execute_sql(sql)
        print("SQL Result:", result)  # Debug
        summary = generate_nl_summary_from_sql_result(result)
        print("Generated Summary:", summary)
        
        return {
            "summary": summary
        }
        #return summary
    except Exception as e:
        print("Error occurred:", e)  # Debug
        raise HTTPException(status_code=500, detail=str(e))
@app.post("/askques")
def ask_question1(data: ApiData):
    try:
        print("Received question:", data.question)  # Debug
        sql = generate_sql_from_question(data.question)
        print("Generated SQL:", sql)  # Debug
        result = execute_sql(sql)
        print("SQL Result:", result)  # Debug
        summary = generate_nl_summary_from_sql_result(result)
        print("Generated Summary:", summary)
        
        return {
            "summary": summary
        }
        #return summary
    except Exception as e:
        print("Error occurred:", e)  # Debug
        raise HTTPException(status_code=500, detail=str(e))