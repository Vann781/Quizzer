from langgraph.graph import StateGraph
from langgraph.graph import START, END

from backend.states import QuizState

from backend.nodes import (
    generate_quiz_node,
    ask_question_node,
    evaluate_answer_node,
    result_node,
    ask_review_choice_node,
    review_answers_node,
    review_router
)

builder = StateGraph(QuizState)

# Register Nodes

builder.add_node(
    "generate_quiz",
    generate_quiz_node
)

builder.add_node(
    "ask_questions",
    ask_question_node
)

builder.add_node(
    "evaluate",
    evaluate_answer_node
)

builder.add_node(
    "result",
    result_node
)

builder.add_node(
    "review_choice",
    ask_review_choice_node
)

builder.add_node(
    "review",
    review_answers_node
)

# Create Flow

builder.add_edge(
    START,
    "generate_quiz"
)

builder.add_edge(
    "generate_quiz",
    "ask_questions"
)

builder.add_edge(
    "ask_questions",
    "evaluate"
)

builder.add_edge(
    "evaluate",
    "result"
)

builder.add_edge(
    "result",
    "review_choice"
)

builder.add_conditional_edges(
    "review_choice",
    review_router,
    {
        "review": "review",
        "end": END
    }
)

builder.add_edge(
    "review",
    END
)

graph = builder.compile()