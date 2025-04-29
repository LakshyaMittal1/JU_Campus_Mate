# app/routers/authority_members_router.py
from fastapi import APIRouter
from app.database import get_connection

router = APIRouter(prefix="/authority", tags=["Authority Members"])

@router.get("/")
def get_all_authorities():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM authority_members")
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result

@router.get("/{authority_id}")
def get_authority_by_id(authority_id: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM authority_members WHERE id = %s", (authority_id,))
    result = cursor.fetchone()
    cursor.close()
    conn.close()
    return result
