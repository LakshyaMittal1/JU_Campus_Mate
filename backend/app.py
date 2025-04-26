# Main FastAPI server
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def home():
    return {"message": "Welcome to JU CampuMate API!"}

'''
✅ This creates:

A FastAPI app

A default / route (home page)
'''