from fastapi import APIRouter
from app.database import get_connection
from fastapi import HTTPException

router = APIRouter(prefix="/mentors", tags=["Class Mentors"])

@router.get("/")
def get_all_mentors():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Class_Mentors")
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result

@router.get("/{mentor_id}")
def get_mentor_by_id(mentor_id: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Class_Mentors WHERE id = %s", (mentor_id,))
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    
    if result:
        return result
    else:
        raise HTTPException(status_code=404, detail="Mentor not found")
