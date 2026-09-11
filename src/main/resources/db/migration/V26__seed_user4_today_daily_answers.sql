-- V24: 능력치(임베딩) 평가 로직을 API 10번 호출 없이 바로 테스트할 수 있도록,
-- user_id=4(박예지, 레벨4)가 오늘의 대표 기사(daily_solo 문제 10개)를 이미 다 풀었다고 가정한 목데이터를 넣는다.
-- 객관식 8개는 전부 정답, OX(정보일치)는 근거를 잘 쓴 정답 케이스, short_answer(핵심파악)는 근거가 부실한 케이스로 넣어서
-- 근거 품질에 따라 능력치 평가(임베딩 유사도)가 달라지는지 비교 테스트할 수 있게 했다.
-- question_id를 하드코딩하지 않고 content로 찾는다: auto-increment id는 DB 초기화/재시딩 여부에 따라 달라질 수 있어서
-- 실제 문제 내용으로 찾는 게 더 안전하다.

-- 1) vocab_meaning (multiple_choice, 정답)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, '특정 집단이 서로 밀어주고 끌어주며 이익을 나누는 결탁 구조', 'correct'::result_status_type, NULL, 10, NULL, '정답이에요!'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%밑줄 친 ''카르텔''의 문맥적 의미로%';

-- 2) vocab_appropriateness (multiple_choice, 정답)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, '동요하고 있다', 'correct'::result_status_type, NULL, 10, NULL, '정답이에요!'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%밑줄 친 표현을 바꿔 써도 문맥상 어색하지 않은 것은%';

-- 3) info_consistency (OX, 정답 + 근거를 잘 씀)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, 'O', 'correct'::result_status_type,
       '기사에 10월 2일 개정 형사소송법이 시행되면 검사의 수사권이 사라지고 경찰이 사건 수사의 중심에 서게 된다고 명시돼 있다.',
       95, NULL, '정답 근거를 정확하게 인용해서 잘 작성했어요.'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%검사의 수사권이 사라지고 경찰이 사건 수사의 중심에 서게 된다%';

-- 4) info_evidence (multiple_choice, 정답)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, '경찰대 출신이 고위직 절반 이상을 차지하고 동국대·고시 특채 출신이 이를 견제한다는 서술', 'correct'::result_status_type, NULL, 10, NULL, '정답이에요!'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%경찰 조직 내부에 출신별 카르텔이 존재한다는 주장을 뒷받침하는 근거로%';

-- 5) core_topic (multiple_choice, 정답)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, '경찰 조직 내 여러 모임의 형성 배경과 성격 차이', 'correct'::result_status_type, NULL, 10, NULL, '정답이에요!'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%이 글이 다루는 중심 소재로 가장 적절한 것은%';

-- 6) core_gist (short_answer, 근거가 부실한 케이스)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, '모임들이 어떻게 만들어졌는지 확인하려고 했다.', 'insufficient_reasoning'::result_status_type,
       '마지막 문단에 나와있다.',
       40, '자금 출처와 정치 세력 연결 의혹을 확인하려 했다는 부분이 빠져서 근거가 부족해요.',
       '답의 방향은 맞지만, 근거를 좀 더 구체적으로 인용해서 써보면 좋겠어요.'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%취재팀이 이 기사를 통해 최종적으로 확인하려 한 것이 무엇인지%';

-- 7) inference_implication (multiple_choice, 정답)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, '경찰 조직의 인사·승진에서 출신에 따른 유불리가 존재할 수 있다', 'correct'::result_status_type, NULL, 10, NULL, '정답이에요!'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%경찰 조직 내에 출신 대학·입직 경로에 따른 카르텔이 존재한다는 서술을 통해 추론할 수 있는%';

-- 8) inference_continuation (multiple_choice, 정답)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, '전국경찰직장협의회와 폴네티앙의 결성 배경, 구성원 수, 자금 출처에 대한 구체적인 취재 내용', 'correct'::result_status_type, NULL, 10, NULL, '정답이에요!'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%이 기사 다음에 이어질 내용으로 가장 자연스러운 것은%';

-- 9) structure_irrelevant_sentence (multiple_choice, 정답)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, '③', 'correct'::result_status_type, NULL, 10, NULL, '정답이에요!'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%다음 중 이 기사의 흐름과 관련 없는 문장은%';

-- 10) structure_sentence_insertion (multiple_choice, 정답)
INSERT INTO user_answers (user_id, question_id, selected_answer, result_status, justification, overall_score, mistake_feedback, feedback)
SELECT 4, question_id, '(나)', 'correct'::result_status_type, NULL, 10, NULL, '정답이에요!'
FROM questions
WHERE game_mode = 'daily_solo'::game_mode_type
  AND content LIKE '%다음 문장이 들어가기에 가장 적절한 위치를 고르시오%';

