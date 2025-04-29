# routers/holidays_router.py

from fastapi import APIRouter, HTTPException, Query
from database import get_connection

router = APIRouter(prefix="/holidays", tags=["Holidays"])

@router.get("/")
def get_all_holidays():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Holidays")
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result

@router.get("/search/")
def get_holiday_by_name(name: str = Query(..., description="Enter holiday name to search")):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    query = "SELECT * FROM holidays WHERE Event LIKE %s"
    cursor.execute(query, (f"%{name}%",))
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    
    if result:
        return result
    else:
        raise HTTPException(status_code=404, detail="Holiday not found")
