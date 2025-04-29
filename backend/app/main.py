# main.py
from fastapi import FastAPI
from routers import (
    mentor_router,
    offices_router,
    authority_members_router,
    holidays_router,
    locations_router
)

app = FastAPI(title="College Chatbot Backend")

# Include all routers
app.include_router(authority_members_router.router)
app.include_router(mentor_router.router)
app.include_router(holidays_router)
app.include_router(offices_router)
app.include_router(locations_router)

@app.get("/")
def read_root():
    return {"message": "College Chatbot Backend is running successfully!"}
