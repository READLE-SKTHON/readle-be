-- ENUM types
CREATE TYPE question_format_type AS ENUM ('OX', 'multiple_choice', 'short_answer');
CREATE TYPE game_mode_type AS ENUM ('daily_solo', 'room', 'category_practice');
CREATE TYPE skill_category_type AS ENUM ('vocab', 'reading', 'inference', 'critical_thinking', 'expression');
CREATE TYPE result_status_type AS ENUM ('correct', 'incorrect', 'insufficient_reasoning');
CREATE TYPE news_category_type AS ENUM ('전체', '정치', '사회', '세계', '과학IT', '생활문화');
CREATE TYPE main_category_type AS ENUM ('vocab', 'info_extraction', 'core_understanding', 'inference_judgment', 'structure');
CREATE TYPE sub_category_type AS ENUM (
    'vocab_appropriateness', 'vocab_meaning', 'vocab_paraphrase',
    'info_consistency', 'info_evidence',
    'core_topic', 'core_title', 'core_gist', 'core_argument',
    'inference_blank', 'inference_implication', 'inference_continuation',
    'structure_sentence_insertion', 'structure_order', 'structure_irrelevant_sentence'
);

-- 학교
CREATE TABLE schools (
    school_id BIGSERIAL PRIMARY KEY,
    school_name VARCHAR(50) NOT NULL,
    point BIGINT,
    school_avg INT
);

-- 사용자
CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL,
    birth TIMESTAMP,
    password VARCHAR(255),
    school_id BIGINT REFERENCES schools(school_id),
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now(),
    level BIGINT,
    xp INT,
    last_activity_date DATE,
    current_streak BIGINT DEFAULT 0,
    answer_rate BIGINT,
    news_read_count INT
);

-- 방만들기
CREATE TABLE game_rooms (
    game_room_id BIGSERIAL PRIMARY KEY,
    room_code BIGINT NOT NULL,
    invite_link VARCHAR(255),
    category news_category_type NOT NULL,
    timer INT NOT NULL,
    member_count INT NOT NULL,
    question_count INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

-- 참여자
CREATE TABLE room_participants (
    room_participants_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    room_id BIGINT NOT NULL REFERENCES game_rooms(game_room_id),
    is_host BOOLEAN NOT NULL,
    score INT,
    joined_at TIMESTAMP NOT NULL DEFAULT now()
);

-- 기사
CREATE TABLE news_articles (
    news_id BIGSERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    category news_category_type NOT NULL,
    publisher VARCHAR(100) NOT NULL,
    published_at TIMESTAMP NOT NULL,
    content TEXT NOT NULL,
    source_url VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

-- 문제
CREATE TABLE questions (
    question_id BIGSERIAL PRIMARY KEY,
    news_id BIGINT NOT NULL REFERENCES news_articles(news_id),
    content TEXT NOT NULL,
    question_format question_format_type NOT NULL,
    choices JSON,
    answer VARCHAR(100) NOT NULL,
    explanation TEXT,
    hint TEXT,
    game_mode game_mode_type NOT NULL,
    main_category main_category_type NOT NULL,
    sub_category sub_category_type,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

-- 사용자 문제풀기
CREATE TABLE user_answers (
    user_answer_id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    question_id BIGINT NOT NULL REFERENCES questions(question_id),
    selected_answer TEXT,
    result_status result_status_type,
    justification TEXT,
    overall_score INT,
    mistake_feedback TEXT,
    feedback TEXT,
    answered_at TIMESTAMP(6)
);

-- 사용자 점수
CREATE TABLE answer_evaluations (
    answer_evaluations_id BIGSERIAL PRIMARY KEY,
    user_answer_id BIGINT NOT NULL REFERENCES user_answers(user_answer_id),
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    skill_category skill_category_type NOT NULL,
    score INT,
    feedback TEXT
);

-- 복습
CREATE TABLE review_sessions (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    is_completed BOOLEAN NOT NULL DEFAULT false,
    question_count INT NOT NULL
);

-- 복습 문제
CREATE TABLE review_session_question (
    id BIGSERIAL PRIMARY KEY,
    review_session_id BIGINT NOT NULL REFERENCES review_sessions(id),
    question_id BIGINT NOT NULL REFERENCES questions(question_id),
    display_order INT NOT NULL
);
