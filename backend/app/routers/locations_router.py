# app/routers/locations_router.py
from fastapi import APIRouter
from database import get_connection

router = APIRouter(prefix="/locations", tags=["Locations"])

@router.get("/")
def get_all_locations():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM locations")
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result

@router.get("/{location_name}")
def get_location_by_name(location_name: str):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM locations WHERE location_name = %s", (location_name,))
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result
