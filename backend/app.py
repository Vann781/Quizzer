from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

try:
    from backend.quiz import generate_questions
except ModuleNotFoundError:
    from quiz import generate_questions

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def home():
    return {
        "message": "Quiz Agent Running"
    }


@app.get("/quiz/{topic}")
def get_quiz(topic):

    questions = generate_questions(topic)

    return {
        "topic": topic,
        "questions": questions
    }