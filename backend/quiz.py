import random


def _shuffle_options(correct: str, wrong: list[str]) -> list[str]:
    options = [correct] + wrong
    random.shuffle(options)
    return options


def generate_questions(topic: str) -> list[dict]:

    topic = topic.lower()

    # ────────────────────────────── PYTHON ──────────────────────────────
    if topic == "python":
        questions = [
            {
                "question": "What keyword is used to define a function?",
                "answer": "def",
                "options": _shuffle_options("def", ["func", "function", "define"]),
            },
            {
                "question": "Which data type stores multiple values?",
                "answer": "list",
                "options": _shuffle_options("list", ["array", "tuple", "set"]),
            },
            {
                "question": "Which keyword is used to create a class?",
                "answer": "class",
                "options": _shuffle_options("class", ["struct", "object", "type"]),
            },
            {
                "question": "What function is used to display output on the screen?",
                "answer": "print",
                "options": _shuffle_options("print", ["write", "echo", "output"]),
            },
            {
                "question": "Which data type is used to store True or False values?",
                "answer": "bool",
                "options": _shuffle_options("bool", ["boolean", "truefalse", "bit"]),
            },
            {
                "question": "What symbol is used to start a comment in Python?",
                "answer": "#",
                "options": _shuffle_options("#", ["//", "/*", "--"]),
            },
            {
                "question": "Which function is used to take input from the user?",
                "answer": "input",
                "options": _shuffle_options("input", ["read", "scan", "get"]),
            },
            {
                "question": "Which keyword is used for conditional statements?",
                "answer": "if",
                "options": _shuffle_options("if", ["when", "switch", "case"]),
            },
            {
                "question": "Which loop is used when the number of iterations is known?",
                "answer": "for",
                "options": _shuffle_options("for", ["while", "do-while", "repeat"]),
            },
            {
                "question": "What data type is used to store decimal numbers?",
                "answer": "float",
                "options": _shuffle_options("float", ["double", "decimal", "number"]),
            },
        ]

    # ────────────────────────────── JAVA ────────────────────────────────
    elif topic == "java":
        questions = [
            {
                "question": "Which keyword is used to define a class in Java?",
                "answer": "class",
                "options": _shuffle_options("class", ["struct", "type", "object"]),
            },
            {
                "question": "Which method is the entry point of a Java program?",
                "answer": "main",
                "options": _shuffle_options("main", ["start", "run", "begin"]),
            },
            {
                "question": "Which keyword is used for inheritance?",
                "answer": "extends",
                "options": _shuffle_options("extends", ["inherits", "implements", "derives"]),
            },
            {
                "question": "Which package is automatically imported in every Java program?",
                "answer": "java.lang",
                "options": _shuffle_options("java.lang", ["java.util", "java.io", "java.base"]),
            },
            {
                "question": "Which keyword is used to create an object?",
                "answer": "new",
                "options": _shuffle_options("new", ["create", "object", "make"]),
            },
        ]

    # ────────────────────────────── DSA ─────────────────────────────────
    elif topic == "dsa":
        questions = [
            {
                "question": "Which data structure follows FIFO?",
                "answer": "queue",
                "options": _shuffle_options("queue", ["stack", "list", "array"]),
            },
            {
                "question": "Which data structure follows LIFO?",
                "answer": "stack",
                "options": _shuffle_options("stack", ["queue", "list", "deque"]),
            },
            {
                "question": "What is the worst-case time complexity of Binary Search?",
                "answer": "O(log n)",
                "options": _shuffle_options("O(log n)", ["O(n)", "O(n\u00b2)", "O(1)"]),
            },
            {
                "question": "Which traversal visits Root, Left, Right?",
                "answer": "preorder",
                "options": _shuffle_options("preorder", ["inorder", "postorder", "levelorder"]),
            },
            {
                "question": "Which data structure is used in Breadth First Search?",
                "answer": "queue",
                "options": _shuffle_options("queue", ["stack", "priority queue", "array"]),
            },
        ]

    # ────────────────────────────── FLUTTER ─────────────────────────────
    elif topic == "flutter":
        questions = [
            {
                "question": "Who developed Flutter?",
                "answer": "google",
                "options": _shuffle_options("google", ["facebook", "apple", "microsoft"]),
            },
            {
                "question": "Which programming language is used by Flutter?",
                "answer": "dart",
                "options": _shuffle_options("dart", ["javascript", "kotlin", "swift"]),
            },
            {
                "question": "What command is used to create a new Flutter project?",
                "answer": "flutter create",
                "options": _shuffle_options("flutter create", ["flutter new", "flutter init", "flutter start"]),
            },
            {
                "question": "What widget is used as the root of most Flutter apps?",
                "answer": "materialapp",
                "options": _shuffle_options("materialapp", ["cupertinoapp", "widgetapp", "app"]),
            },
            {
                "question": "Which widget is used to display text?",
                "answer": "text",
                "options": _shuffle_options("text", ["label", "paragraph", "string"]),
            },
            {
                "question": "Which widget arranges children vertically?",
                "answer": "column",
                "options": _shuffle_options("column", ["row", "stack", "listview"]),
            },
            {
                "question": "Which widget arranges children horizontally?",
                "answer": "row",
                "options": _shuffle_options("row", ["column", "stack", "listview"]),
            },
            {
                "question": "Which widget creates a scrollable list?",
                "answer": "listview",
                "options": _shuffle_options("listview", ["scrollview", "column", "gridview"]),
            },
            {
                "question": "What command is used to run a Flutter application?",
                "answer": "flutter run",
                "options": _shuffle_options("flutter run", ["flutter start", "flutter execute", "flutter build"]),
            },
            {
                "question": "Which file contains the entry point of a Flutter application?",
                "answer": "main.dart",
                "options": _shuffle_options("main.dart", ["app.dart", "index.dart", "start.dart"]),
            },
            {
                "question": "What function is the entry point of every Flutter app?",
                "answer": "main",
                "options": _shuffle_options("main", ["run", "start", "init"]),
            },
            {
                "question": "Which widget is commonly used to create app bars?",
                "answer": "appbar",
                "options": _shuffle_options("appbar", ["toolbar", "navbar", "header"]),
            },
            {
                "question": "What widget is used to create clickable buttons?",
                "answer": "elevatedbutton",
                "options": _shuffle_options("elevatedbutton", ["button", "clickable", "flatbutton"]),
            },
            {
                "question": "Which widget is used for user input?",
                "answer": "textfield",
                "options": _shuffle_options("textfield", ["input", "textbox", "formfield"]),
            },
            {
                "question": "What command checks Flutter installation status?",
                "answer": "flutter doctor",
                "options": _shuffle_options("flutter doctor", ["flutter check", "flutter status", "flutter inspect"]),
            },
            {
                "question": "Which widget allows stacking widgets on top of each other?",
                "answer": "stack",
                "options": _shuffle_options("stack", ["column", "overlay", "layer"]),
            },
            {
                "question": "What is used to manage state in Flutter?",
                "answer": "setstate",
                "options": _shuffle_options("setstate", ["update", "refresh", "reload"]),
            },
            {
                "question": "Which package is commonly used for state management?",
                "answer": "provider",
                "options": _shuffle_options("provider", ["redux", "bloc", "mobx"]),
            },
            {
                "question": "Which database is commonly integrated with Flutter for cloud storage?",
                "answer": "firebase",
                "options": _shuffle_options("firebase", ["mongodb", "sqlite", "mysql"]),
            },
            {
                "question": "What does Hot Reload do?",
                "answer": "updates ui without restarting app",
                "options": _shuffle_options(
                    "updates ui without restarting app",
                    ["restarts the app", "compiles the code", "installs dependencies"],
                ),
            },
        ]

    # ────────────────────────────── AI ──────────────────────────────────
    elif topic == "ai":
        questions = [
            {
                "question": "What does AI stand for?",
                "answer": "artificial intelligence",
                "options": _shuffle_options(
                    "artificial intelligence",
                    ["automated intelligence", "artificial integration", "advanced intelligence"],
                ),
            },
            {
                "question": "What does ML stand for?",
                "answer": "machine learning",
                "options": _shuffle_options(
                    "machine learning",
                    ["mechanical learning", "machine logic", "modern learning"],
                ),
            },
            {
                "question": "Which type of learning uses labeled data?",
                "answer": "supervised learning",
                "options": _shuffle_options(
                    "supervised learning",
                    ["unsupervised learning", "reinforcement learning", "semi-supervised learning"],
                ),
            },
            {
                "question": "Which neural network is commonly used for image processing?",
                "answer": "cnn",
                "options": _shuffle_options("cnn", ["rnn", "gan", "transformer"]),
            },
            {
                "question": "What does NLP stand for?",
                "answer": "natural language processing",
                "options": _shuffle_options(
                    "natural language processing",
                    ["neural language processing", "natural logic processing", "network language protocol"],
                ),
            },
        ]

    # ────────────────────────────── DEFAULT ─────────────────────────────
    else:
        questions = [
            {
                "question": "What does CPU stand for?",
                "answer": "central processing unit",
                "options": _shuffle_options(
                    "central processing unit",
                    ["computer processing unit", "central program unit", "core processing unit"],
                ),
            },
            {
                "question": "What does RAM stand for?",
                "answer": "random access memory",
                "options": _shuffle_options(
                    "random access memory",
                    ["read access memory", "random application memory", "rapid access memory"],
                ),
            },
            {
                "question": "What is the brain of the computer?",
                "answer": "cpu",
                "options": _shuffle_options("cpu", ["gpu", "ram", "hard drive"]),
            },
        ]

    return questions
