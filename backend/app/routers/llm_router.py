""" # app/routers/llm_router.py

from fastapi import APIRouter, Query
from app.llm_agent import query_database

router = APIRouter(prefix="/llm", tags=["LLM SQL Assistant"])

@router.get("/ask")
def ask_llm(question: str = Query(..., description="Ask a natural language question about the university.")):
    try:
        result = query_database(question)
        return {"query": question, "response": result}
    except Exception as e:
        return {"error": str(e)}
 """


# app/routers/llm_router.py

from fastapi import APIRouter, Query
from app.llm_agent import query_database

router = APIRouter(prefix="/ask", tags=["LLM"])

@router.get("/")
def ask_question(q: str = Query(..., description="Ask any question related to university")):
    return {"response": query_database(q)}
