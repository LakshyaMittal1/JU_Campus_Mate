# just a test file to check if the llm agent is working
#this is the test file to check if the llm agent is working

# before testing using the uvicorn command, run this file and check if you are getting the correct response from the llm agent in your terminal.

# and after successfully testing the llm agent here in the terminal, you can run the uvicorn command to run the main.py file and check if the llm agent is working in your browser.



# run this file using the command (in the terminal in the current folder (backend/app) ): python test_llm.py 

from llm_agent import query_database

response = query_database("Who is the Dean of MCA?")
print(response)