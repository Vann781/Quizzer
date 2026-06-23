from typing import TypedDict, List

class QuizState(TypedDict):
    topic: str
    questions: List[dict]
    current_question: int
    user_answers: List[str]
    score: int
    final_result: str
    review_choice: str