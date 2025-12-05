import os
from google import genai
from dotenv import load_dotenv
import json

load_dotenv()

# Load API key
client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))

with open("NL2SQL.txt", "r", encoding="utf-8") as f:
    NL2SQL_PROMPT = f.read()

with open("SQL2NL.txt", "r", encoding="utf-8") as f:
    SQL2NL_PROMPT = f.read()


def generate_sql_from_question(question: str) -> str:
    """Generate SQL using Gemini 2.5 Flash."""

    prompt = (
        NL2SQL_PROMPT
        + "\nUser Question: "
        + question
        + "\nGenerated SQL Query:\n"
    )

    response = client.models.generate_content(
        model="gemini-2.5-flash",
        # model="gemini-2.5-pro",
        contents=prompt
    )

    return response.text.strip()


def generate_nl_summary_from_sql_result(sql_result: list[dict]) -> str:
    """Convert SQL result to natural language."""

    result_str = json.dumps(sql_result, indent=2)

    prompt = (
        SQL2NL_PROMPT
        + "\nSQL Result:\n"
        + result_str
        + "\nNatural Language Summary:\n"
    )

    response = client.models.generate_content(
        # model="gemini-2.5-flash",
        model="gemini-2.5-pro",
        contents=prompt
    )

    return response.text.strip()
