
# This file needs to be completed... This is the soul of our project.
# It connects the LLM to the database and handles the queries.
# It should be able to take a natural language question, convert it to SQL, and return the results from the database in natural language.
# The problem is to find a really good LLM focused for text - to - SQL that is free and open source.






# # # # app/llm_agent.py

# # # import os
# # # from langchain_community.llms import HuggingFaceHub
# # # from langchain_experimental.sql import SQLDatabaseChain
# # # # from langchain.sql_database import SQLDatabase # (deprecated)
# # # from langchain_community.utilities import SQLDatabase
# # # from dotenv import load_dotenv 

# # # load_dotenv()

# # # # Connect to MySQL
# # # db = SQLDatabase.from_uri(
# # #     "mysql+mysqlconnector://root:1234@localhost/chatbot_university"
# # # )

# # # # LLM from Hugging Face Inference API
# # # """ llm = HuggingFaceHub(
# # #     repo_id="defog/sqlcoder",  # You can try other text2sql models too
# # #     model_kwargs={"temperature": 0.2, "max_new_tokens": 512}
# # # )
# # #  """

# # # """ llm = HuggingFaceHub(
# # #     repo_id="defog/falcon-text-to-sql",  # ✅ A smaller hosted model
# # #     model_kwargs={"temperature": 0.5, "max_length": 500}
# # # ) """


# # # """ llm = HuggingFaceHub(
# # #     repo_id="mistralai/Mistral-7B-Instruct-v0.1",
# # #     model_kwargs={"temperature": 0.5, "max_new_tokens": 512}
# # # ) """

# # # llm = HuggingFaceHub(
# # #     # repo_id="bgeron/sqlcoder-llama2-7b-chat",
# # #     # repo_id="google/flan-t5-xxl",  # You can try other text2sql models too
# # #     repo_id="llmware/slim-sql-1b-v0",
# # #     # repo_id="defog/sqlcoder-7b-2",
# # #     model_kwargs={"temperature": 0.2, "max_new_tokens": 256}
# # # )



# # # # SQL chain
# # # db_chain = SQLDatabaseChain.from_llm(llm, db, verbose=True)

# # # def query_database(question: str):
# # #     return db_chain.run(question)


# # # app/llm_agent.py

# # import os
# # from dotenv import load_dotenv

# # # new HF Inference client
# # from huggingface_hub import InferenceClient

# # # LangChain pieces
# # from langchain_community.utilities import SQLDatabase
# # from langchain_experimental.sql import SQLDatabaseChain
# # # from langchain_core.language_models.llms import HuggingFaceEndpoint
# # from langchain_huggingface import HuggingFaceEndpoint


# # # 1) load your HF token from .env
# # load_dotenv()
# # hf_token = os.getenv("HUGGINGFACEHUB_API_TOKEN")

# # # 2) connect to MySQL
# # db = SQLDatabase.from_uri(
# #     "mysql+mysqlconnector://root:1234@localhost/chatbot_university"
# # )

# # # 3) create an HF InferenceClient (text-generation task)
# # client = InferenceClient(
# #     token=hf_token,
# #     task="text-generation"
# # )

# # # 4) wrap it in a LangChain LLM endpoint
# # llm = HuggingFaceEndpoint(
# #     inference_client=client,
# #     model_name="llmware/slim-sql-1b-v0",
# #     # you can tune these
# #     max_new_tokens=256,
# #     temperature=0.2
# # )

# # # 5) build the SQL-chain
# # db_chain = SQLDatabaseChain.from_llm(llm=llm, database=db, verbose=False)

# # def query_database(question: str) -> str:
# #     """
# #     1) Send the natural-language question to slim-sql-1b-v0
# #     2) It returns a SQL string, executes on MySQL
# #     3) Returns the result, formatted in plain text
# #     """
# #     return db_chain.run(question)

# # app/llm_agent.py

# import os
# from dotenv import load_dotenv

# from huggingface_hub import InferenceClient
# from langchain_community.utilities import SQLDatabase
# import mysql.connector

# load_dotenv()
# hf_token = os.getenv("HUGGINGFACEHUB_API_TOKEN")

# # 1) set up HF InferenceClient properly:
# client = InferenceClient(
#     model="llmware/slim-sql-1b-v0",   # pass the model here
#     token=hf_token
# )

# # 2) database connection (raw MySQL connector)
# def get_db_connection():
#     return mysql.connector.connect(
#         host="localhost",
#         user="root",
#         password="1234",
#         database="chatbot_university"
#     )

# def query_database(question: str) -> str:
#     # 3) ask the model to generate SQL
#     sql_out = client.text_generation(
#         prompt=f"Generate SQL for: {question}",
#         max_new_tokens=256,
#         temperature=0.2,
#     )
#     # `sql_out` is a dict with a .generated_text field (or similar)
#     sql = sql_out.generated_text.strip()
#     print("🔍 Generated SQL:", sql)

#     # 4) run the SQL against MySQL
#     conn = get_db_connection()
#     cursor = conn.cursor(dictionary=True)
#     cursor.execute(sql)
#     rows = cursor.fetchall()
#     cursor.close()
#     conn.close()

#     # 5) format rows into a human-readable string
#     if not rows:
#         return "No results."
#     # simple formatting: list of dicts → text
#     lines = []
#     for r in rows:
#         parts = [f"{k}={v}" for k, v in r.items()]
#         lines.append(", ".join(parts))
#     return "\n".join(lines)
