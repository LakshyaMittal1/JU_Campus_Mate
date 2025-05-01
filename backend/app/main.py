""" 
# this is the old main.py file which is not used anymore

# # main.py
# from fastapi import FastAPI
# from app.routers import router as holidays_router
# from app.routers import router as authority_members_router
# from app.routers import router as mentor_router
# from app.routers import router as offices_router
# from app.routers import router as locations_router


# app = FastAPI(title="College Chatbot Backend")

# # Include all routers
# app.include_router(authority_members_router.router)
# app.include_router(mentor_router.router)
# app.include_router(holidays_router)
# app.include_router(offices_router)
# app.include_router(locations_router)

# @app.get("/")
# def read_root():
#     return {"message": "College Chatbot Backend is running successfully!"}
 """


from fastapi import FastAPI
from app.routers import holidays_router, authority_members_router, mentor_router, offices_router, locations_router
from app.routers.llm_router import router as llm_router
# from app.database import get_connection
app = FastAPI(title="College Chatbot Backend")

# Include all routers
app.include_router(holidays_router)
app.include_router(authority_members_router)
app.include_router(mentor_router)
app.include_router(offices_router)
app.include_router(locations_router)
app.include_router(llm_router)

@app.get("/")
def read_root():
    return {"message": "College Chatbot Backend is running successfully!"}
