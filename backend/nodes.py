from backend.quiz import generate_questions


def generate_quiz_node(state):

    questions = generate_questions(
        state["topic"]
    )

    return {
        "questions": questions
    }

def ask_question_node(state):

    answers = []

    print("\nQuiz Started")
    print("-" * 40)

    for index, question in enumerate(state["questions"]):

        user_answer = input(
            f"\nQ{index + 1}: {question['question']}\nYour Answer: "
        )

        answers.append(user_answer)

    return {
        "user_answers": answers
    }


def evaluate_answer_node(state):

    score = 0

    for i in range(len(state["questions"])):

        correct = state["questions"][i]["answer"]

        user = state["user_answers"][i]

        if user.strip().casefold() == correct.strip().casefold():
            score += 1

    return {
        "score": score
    }

def result_node(state):

    total_questions = len(state["questions"])

    result = (
        f"You scored {state['score']} out of {total_questions}"
    )

    print("\n" + "=" * 40)
    print(result)
    print("=" * 40)

    return {
        "final_result": result
    }


def ask_review_choice_node(state):

    choice = input(
        "\nWould you like to review your answers? (yes/no): "
    )

    return {
        "review_choice": choice.strip().lower()
    }


def review_answers_node(state):

    print("\n")
    print("=" * 50)
    print("ANSWER REVIEW")
    print("=" * 50)

    questions = state["questions"]
    answers = state["user_answers"]

    for i in range(len(questions)):

        print(f"\nQuestion {i+1}")
        print(f"Q : {questions[i]['question']}")
        print(f"Your Answer    : {answers[i]}")
        print(f"Correct Answer : {questions[i]['answer']}")

    return {}


def review_router(state):

    if state["review_choice"] == "yes":
        return "review"

    return "end"