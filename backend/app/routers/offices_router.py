# app/routers/offices_router.py
from fastapi import APIRouter
from database import get_connection

router = APIRouter(prefix="/offices", tags=["Offices"])

@router.get("/")
def get_all_offices():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM offices")
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result

@router.get("/{office_name}")
def get_office_by_name(office_name: str):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM offices WHERE office_name = %s", (office_name,))
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result
