# main.py
from fastapi import FastAPI
from routers import (
    #faculty_router,
    #labs_router,
    #syllabus_router,
    mentor_router,
    #contacts_router,
    #holidays_router,
)

app = FastAPI(title="College Chatbot Backend")

# Include all routers
#app.include_router(faculty_router.router)
#app.include_router(labs_router.router)
#app.include_router(syllabus_router.router)
app.include_router(mentor_router.router)
#app.include_router(contacts_router.router)
#app.include_router(holidays_router.router)

@app.get("/")
def read_root():
    return {"message": "College Chatbot Backend is running successfully!"}
