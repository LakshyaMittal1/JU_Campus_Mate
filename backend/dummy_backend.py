
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
# python -m uvicorn dummy_backend:app --host 0.0.0.0 --port 5000