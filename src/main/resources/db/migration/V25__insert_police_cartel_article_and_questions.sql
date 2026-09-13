-- 기사(''투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'')는 이미 DB에 있음(V6/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '기사에 나온 ''카르텔''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["서로 이익을 위해 뭉친 폐쇄적인 집단", "정부가 공식적으로 운영하는 위원회", "경찰이 사용하는 무전기의 한 종류", "법으로 정해진 경찰 계급 체계"]'::json,
    '서로 이익을 위해 뭉친 폐쇄적인 집단',
    '카르텔은 서로 이익을 주고받으며 폐쇄적으로 뭉친 집단을 뜻하며, 기사에서는 출신별로 밀어주고 끌어주는 경찰 내부 세력을 가리킨다.',
    '기사 중반에서 "출신 대학과 입직 경로에 따라 서로 밀어주고 끌어주는" 부분이 어떤 개념을 설명하는지 살펴보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    4
),
-- 2. vocab / vocab_appropriateness (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '"경찰 조직이 술렁이고 있다"에서 ''술렁이고''를 가장 자연스럽게 바꿔 쓸 수 있는 단어는 무엇인가요?',
    'multiple_choice',
    '["동요하고", "안정되고", "침묵하고", "해체되고"]'::json,
    '동요하고',
    '''술렁이다''는 어수선하게 소란이 일거나 불안하게 움직인다는 뜻이므로 ''동요하다''로 바꿔도 문맥이 자연스럽다.',
    '뒤에 이어지는 개혁 요구와 형사소송법 시행 등 조직 내부가 불안정해진 상황과 어울리는 단어인지 생각해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_appropriateness',
    4
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '10월 2일 개정 형사소송법이 시행되면 검사의 수사권이 사라지고 경찰이 수사의 중심이 됩니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '기사에 10월 2일 개정 형사소송법 시행으로 검사의 수사권이 사라지고 경찰이 사건 수사의 중심에 선다고 명시돼 있다.',
    '세 번째 문단에서 형사소송법 개정과 관련된 문장을 다시 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    4
),
-- 4. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '기사에서 두 모임(전국경찰직장협의회, 폴네티앙)이 강조하는 관심사가 서로 달랐다고 판단한 근거로 제시한 사실은 무엇인가요?',
    'short_answer',
    '[]'::json,
    '두 단체가 같은 장소에서 하루 간격으로 각각 행사를 연 것',
    '기사는 두 단체가 같은 장소에서 하루 간격으로 각각 별도 행사를 열었다는 사실을 관심사가 다르다는 판단의 근거로 제시했다.',
    '''두 모임이 강조하는 관심사는 서로 달랐다''는 문장 바로 앞에 어떤 사실이 나오는지 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    4
),
-- 5. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '이 기사 전체가 다루는 중심 소재는 무엇인가요?',
    'multiple_choice',
    '["경찰 조직 내 다양한 모임과 그 활동 배경", "형사소송법 개정의 세부 조항 해설", "장윤기 사건과 제주 실종 사건의 수사 결과", "경찰대학교의 입학 절차와 교육 과정"]'::json,
    '경찰 조직 내 다양한 모임과 그 활동 배경',
    '기사는 전국경찰직장협의회, 폴네티앙, 경찰젠더연구회 등 경찰 내 여러 모임이 생겨난 배경과 활동을 중심으로 다루고 있다.',
    '기사 제목과 마지막 문단에서 취재팀이 확인하려 한 대상이 무엇인지 살펴보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    4
),
-- 6. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '이 기사가 최종적으로 전달하려는 핵심 메시지로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["경찰 조직 내부는 출신과 이슈에 따라 여러 모임으로 나뉘어 각자 목소리를 내고 있다.", "경찰 조직은 하나의 목소리로 완전히 통합되어 있다.", "검찰이 수사권을 계속 독점하게 되어 경찰의 역할이 축소된다.", "경찰젠더연구회가 다른 모든 모임을 흡수하며 세력을 키우고 있다."]'::json,
    '경찰 조직 내부는 출신과 이슈에 따라 여러 모임으로 나뉘어 각자 목소리를 내고 있다.',
    '기사는 경찰 조직이 하나로 뭉치지 않고 출신 카르텔과 이슈별 모임으로 나뉘어 각기 다른 목소리를 낸다는 점을 핵심으로 전달한다.',
    '다섯 번째 문단의 질문("왜 하나로 뭉치지 않고 각기 다른 이슈를 내세우며 따로 모이는 것일까")과 그 답을 다시 읽어보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    4
),
-- 7. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '취재팀이 세 모임의 자금 출처와 의혹을 확인하려 한 이유로 가장 알맞은 것은 무엇인가요?',
    'multiple_choice',
    '["이 모임들이 최대 권력 집단으로 떠오른 경찰 조직에 미치는 영향력이 커지고 있어서", "이 모임들이 곧 해체될 위기에 처해 있어서", "정부가 이 모임들에 대한 조사를 이미 마쳤기 때문에", "세 모임이 서로 완전히 같은 주장을 펼치고 있어서"]'::json,
    '이 모임들이 최대 권력 집단으로 떠오른 경찰 조직에 미치는 영향력이 커지고 있어서',
    '기사는 최대 권력 집단으로 떠오르는 경찰 조직 내에서 이들 모임의 규모와 영향력이 커지는 상황을 배경으로 취재 이유를 설명한다.',
    '여섯 번째 문단 첫 문장에서 경찰 조직을 어떻게 표현했는지 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    4
),
-- 8. inference_judgment / inference_blank (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '다음 문장의 빈칸에는 ''검찰''이 들어가는 것이 적절합니다. "10월 2일 개정 형사소송법이 시행되면 ____의 수사권이 사라지고 경찰이 사건 수사의 중심에 선다." (O/X)',
    'OX',
    '[]'::json,
    'O',
    '기사에 따르면 개정법 시행으로 검사(검찰)의 수사권이 사라진다고 나와 있으므로 빈칸에 ''검찰''이 들어가는 것은 적절하다.',
    '세 번째 문단에서 수사권을 잃게 되는 주체가 누구인지 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    4
),
-- 9. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '기사에 나온 사건들을 시간 순서대로 바르게 나열한 것은 무엇인가요?
(A) 9월 6일 전국경찰직장협의회 토론회
(B) 9월 7일 폴네티앙 토론회
(C) 10월 2일 개정 형사소송법 시행
(D) 장윤기 사건·제주 실종 사건으로 개혁 요구 확산',
    'multiple_choice',
    '["D-A-B-C", "A-B-C-D", "D-B-A-C", "A-D-B-C"]'::json,
    'D-A-B-C',
    '두 사건으로 개혁 요구가 커진 뒤 9월 6일과 7일 토론회가 이어지고, 이후 10월 2일 형사소송법이 시행되는 흐름이다.',
    '세 번째 문단의 사건 계기와 네 번째 문단의 토론회 날짜, 그리고 법 시행일을 순서대로 정리해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    4
),
-- 10. structure / structure_irrelevant_sentence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '다음 중 기사의 전체적인 흐름과 관계없는 문장은 무엇인가요?',
    'multiple_choice',
    '["경찰 내부에는 출신 대학과 입직 경로에 따른 카르텔이 존재한다.", "폴네티앙은 황운하 의원, 인권연대와 함께 토론회를 열었다.", "서울 강남구에는 최근 대형 쇼핑몰이 새로 문을 열었다.", "경찰젠더연구회는 11월에 별도 행사를 열 예정이다."]'::json,
    '서울 강남구에는 최근 대형 쇼핑몰이 새로 문을 열었다.',
    '이 기사는 경찰 조직 내 모임들의 활동과 배경을 다루므로, 쇼핑몰 개장과 관련된 문장은 흐름과 무관하다.',
    '경찰 조직과 전혀 관계없는 소재를 다룬 보기를 찾아보세요.',
    'daily_solo',
    'structure',
    'structure_irrelevant_sentence',
    4
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 지난 6일 일요일 오후 2시, 서울 여의도 국회의원회관에는 삭발을 한 이들을 포함해 경찰 150여 명이 하나둘 모여들었다.

[문제] ''삭발을 한''이 의미하는 바로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["머리카락을 짧게 밀어 깎은", "머리를 길게 기른", "모자를 눌러쓴", "안경을 착용한"]'::json,
    '머리카락을 짧게 밀어 깎은',
    '''삭발하다''는 머리카락을 짧게 밀어 깎는 행위를 뜻하며, 강한 항의의 의미로 종종 사용된다.',
    '문단에서 경찰들이 어떤 모습으로 모였는지 나타내는 표현을 다시 확인해 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    4
),
-- 12. vocab / vocab_paraphrase (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 다음 날인 7일 오후 2시, 같은 장소에는 부산·목포·거제 등 전국 각지에서 올라온 전·현직 경찰 40여 명이 모였다.

[문제] ''전·현직 경찰''은 ''예전에 경찰이었거나 지금 경찰인 사람들''로 바꿔 쓸 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''전·현직''은 이전 직위에 있었던 사람과 현재 그 직위에 있는 사람을 함께 가리키는 말이므로 올바른 해석이다.',
    '''전(前)''과 ''현(現)''이라는 한자가 각각 어떤 뜻인지 떠올려 보세요.',
    'room',
    'vocab',
    'vocab_paraphrase',
    4
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 전국 13만 4000명에 달하는 경찰 조직이 술렁이고 있다. 최근 장윤기 사건과 제주 실종 사건을 계기로 경찰 개혁을 요구하는 목소리가 커진 데다, 10월 2일 개정 형사소송법 시행으로 검사의 수사권이 사라지고 경찰이 사건 수사의 중심에 서게 되기 때문이다.

[문제] 전국 경찰 인원은 13만 4000명입니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '문단에 전국 13만 4000명에 달하는 경찰 조직이라고 명시돼 있으므로 올바른 설명이다.',
    '문단 첫 문장에 나오는 숫자를 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    4
),
-- 14. info_extraction / info_evidence (short_answer, 한 단어)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 전국 13만 4000명에 달하는 경찰 조직이 술렁이고 있다. 최근 장윤기 사건과 제주 실종 사건을 계기로 경찰 개혁을 요구하는 목소리가 커진 데다, 10월 2일 개정 형사소송법 시행으로 검사의 수사권이 사라지고 경찰이 사건 수사의 중심에 서게 되기 때문이다.

[문제] 경찰이 사건 수사의 중심이 되는 근거로 제시된 법은 무엇인가요?',
    'short_answer',
    '[]'::json,
    '형사소송법',
    '문단에서 10월 2일 개정 형사소송법 시행이 경찰이 수사의 중심이 되는 근거로 제시되었다.',
    '문단 뒷부분에서 어떤 법이 언제 시행된다고 했는지 찾아보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    4
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 이런 분위기를 반영하듯 국회에서는 9월 6일과 7일 이틀 연속으로 경찰 관련 토론회가 열렸다. 6일 행사는 전국경찰직장협의회가 조국혁신당 정춘생 의원과 함께, 7일 행사는 폴네티앙이 조국혁신당 황운하 의원, 인권연대와 함께 주최했다.

[문제] 이 문단이 다루는 중심 소재는 무엇인가요?',
    'multiple_choice',
    '["국회에서 이틀 연속 열린 경찰 관련 토론회", "형사소송법 개정 절차의 세부 내용", "경찰대학교 입학 시험 일정", "제주 실종 사건의 수사 경과"]'::json,
    '국회에서 이틀 연속 열린 경찰 관련 토론회',
    '문단은 9월 6일과 7일 이틀 연속 국회에서 열린 경찰 관련 토론회를 중심으로 설명하고 있다.',
    '문단 첫 문장에서 어떤 행사가 이틀 연속 열렸다고 했는지 확인해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    4
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 최대 권력 집단으로 떠오르는 경찰 조직 안에서, 구성원들은 왜 하나로 뭉치지 않고 각기 다른 이슈를 내세우며 따로 모이는 것일까. 이 조직 내부에는 출신 대학과 입직 경로에 따라 서로 밀어주고 끌어주는 카르텔이 존재한다.

[문제] 이 문단에 가장 잘 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["경찰 조직 내부의 출신별 카르텔 구조", "경찰관 채용 시험 합격자 발표", "경찰차 순찰 노선 변경 계획", "경찰 제복 디자인 개편 논의"]'::json,
    '경찰 조직 내부의 출신별 카르텔 구조',
    '문단은 경찰 조직이 하나로 뭉치지 않는 이유로 출신 대학과 입직 경로에 따른 카르텔 구조를 설명하고 있다.',
    '문단에서 반복해서 등장하는 ''카르텔''이라는 단어가 무엇을 설명하는지 살펴보세요.',
    'room',
    'core_understanding',
    'core_title',
    4
),
-- 17. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 그러나 일선 현장에서는 순경 출신이 압도적으로 많고, 이들의 목소리와 행동이 조직 전체의 방향을 좌우한다.

[문제] 이 문장을 통해 추론할 수 있는 내용으로 가장 알맞은 것은 무엇인가요?',
    'multiple_choice',
    '["현장 다수를 차지하는 순경 출신의 영향력이 경찰 조직 운영에 크게 작용한다.", "경찰 고위직은 모두 순경 출신으로만 구성되어 있다.", "순경 출신은 조직 운영에 전혀 영향을 미치지 못한다.", "경찰대 출신이 현장 인원의 대다수를 차지한다."]'::json,
    '현장 다수를 차지하는 순경 출신의 영향력이 경찰 조직 운영에 크게 작용한다.',
    '순경 출신이 현장에 압도적으로 많고 이들의 목소리가 조직 방향을 좌우한다고 했으므로, 이들의 영향력이 크다는 것을 추론할 수 있다.',
    '''이들의 목소리와 행동이 조직 전체의 방향을 좌우한다''는 표현이 의미하는 바를 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    4
),
-- 18. inference_judgment / inference_blank (short_answer, 한 단어)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 이런 출신별 카르텔과는 별개로, 여러 출신과 계급이 뒤섞여 활동하는 모임들도 있다. 전국경찰직장협의회, 폴네티앙, ____이(가) 그것이다.

[문제] 빈칸에 들어갈 모임의 이름은 무엇인가요?',
    'short_answer',
    '[]'::json,
    '경찰젠더연구회',
    '문단 뒤에 이어지는 문장에서 전국경찰직장협의회, 폴네티앙과 함께 경찰젠더연구회가 언급된다.',
    '문단 바로 다음 문장에서 나열된 세 모임의 이름을 확인해 보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    4
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 취재팀은 이들 조직이 어떻게 만들어졌는지, 몇 명이 어떤 자금으로 활동하는지, 그리고 보수 진영 일각에서 제기해온 의혹이 사실인지를 확인하고자 했다.

[문제] 취재팀이 확인하고자 한 순서로 옳게 나열된 것은 무엇인가요?
(A) 자금 출처 (B) 조직 결성 과정 (C) 의혹의 사실 여부',
    'multiple_choice',
    '["(B)-(A)-(C)", "(A)-(B)-(C)", "(C)-(B)-(A)", "(A)-(C)-(B)"]'::json,
    '(B)-(A)-(C)',
    '문장 순서상 조직이 어떻게 만들어졌는지(B), 어떤 자금으로 활동하는지(A), 의혹이 사실인지(C) 순으로 나열되어 있다.',
    '문장에서 ''만들어졌는지 → 자금으로 활동하는지 → 의혹이 사실인지'' 순서를 따라가 보세요.',
    'room',
    'structure',
    'structure_order',
    4
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '투쟁기금 단숨에 1.5억 모았다…''공룡 경찰'' 3대 모임 해부'),
    '[문단] 오는 11월에는 여성 경찰들의 모임인 경찰젠더연구회도 별도 행사를 열 예정이며, [ ㄱ ] 이 모임의 규모 역시 점점 커지고 있다.

[문제] [ ㄱ ]에 들어갈 접속어로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["또한", "하지만", "왜냐하면", "그런데도"]'::json,
    '또한',
    '앞 문장과 뒤 문장이 모두 경찰젠더연구회에 대한 긍정적인 확장 내용을 추가로 설명하므로 첨가를 나타내는 ''또한''이 적절하다.',
    '앞 문장(행사 예정)과 뒤 문장(규모 확대)이 비슷한 방향의 내용을 이어가는지 살펴보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    4
);

-- 기사(''실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'')는 이미 DB에 있음(V6/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '다음 중 기사에 나온 ''초고령사회''의 뜻으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["노인 인구의 비율이 전체 사회에서 매우 높은 상태", "어린이와 청소년 수가 노인보다 훨씬 많은 상태", "노인들이 도시가 아닌 시골에서만 살아가는 상태", "젊은 사람들이 일자리를 찾아 외국으로 나가는 상태"]'::json,
    '노인 인구의 비율이 전체 사회에서 매우 높은 상태',
    '초고령사회는 전체 인구 중에서 65세 이상 노인이 차지하는 비율이 매우 높아진 사회를 의미합니다.',
    '1문단 첫 문장에서 경남의 노인 인구 변화와 관련하여 쓰인 단어의 뜻을 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    3
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '기사의 "기존 주택을 안전하게 고치고"에서 ''고치고''와 가장 의미가 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["수리하고", "부수고", "구입하고", "방치하고"]'::json,
    '수리하고',
    '''고치다''는 낡거나 고장 난 것을 올바르고 안전하게 바꾸는 것이므로 ''수리하다''와 같은 의미입니다.',
    '1문단에서 오래된 집을 안전하게 만드는 행동을 뜻하는 단어를 찾아보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    3
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '부산의 라우어 시니어타운은 일붕실버랜드에 비해 입주 비용이 훨씬 저렴한 편입니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '4문단을 보면 라우어 시니어타운은 수억 원대 보증금과 월 수백만 원이 필요하여 일붕실버랜드보다 비용이 훨씬 높다고 나와 있습니다.',
    '3문단의 일붕실버랜드 비용과 4문단의 라우어 시니어타운 비용을 비교해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    3
),
-- 4. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '국민연금공단 연구에 따르면, 현재 노인 주거 정책에서 어떤 계층을 위한 주거 공간이 가장 부족하다고 지적했나요?',
    'short_answer',
    '[]'::json,
    '중산층',
    '6문단에서 공공 주택(저소득층)과 고가 민간 시설(고소득층) 사이에 놓인 중산층 노인을 위한 주거가 부족하다고 설명합니다.',
    '6문단을 읽고 공공 주택과 고급 실버타운 사이에 끼어 있는 계층이 누구인지 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    3
),
-- 5. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '이 기사 전체에서 주로 다루고 있는 핵심 주제는 무엇인가요?',
    'multiple_choice',
    '["고령화 사회에 따른 노인 주거 문제와 다양한 주거 대안의 필요성", "실버타운 내 피트니스센터와 수영장을 설치하는 최신 방법", "경남 지역 노인들이 선호하는 해외 여행지 및 여가 활동", "국민연금공단의 연금 수령액 인상을 위한 법적 절차"]'::json,
    '고령화 사회에 따른 노인 주거 문제와 다양한 주거 대안의 필요성',
    '글 전체가 노인 주거 시설의 현황과 한계를 지적하며 중산층 및 복합형 주거 대안의 필요성을 다루고 있습니다.',
    '글의 제목과 각 문단에서 공통으로 다루는 ''노인의 거주 공간''에 관한 문제의식을 떠올려 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    3
),
-- 6. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '이 글을 쓴 기자의 핵심 메시지(결론)로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["중산층 노인도 이용할 수 있는 의료·돌봄 결합형 주택이 늘어나야 한다.", "모든 노인은 무조건 자녀와 함께 사는 법적 제도를 만들어야 한다.", "고급 호텔형 실버타운을 전국 각지에 대규모로 건설해야 한다.", "시골 지역의 낡은 집들을 모두 허물고 아파트를 새로 지어야 한다."]'::json,
    '중산층 노인도 이용할 수 있는 의료·돌봄 결합형 주택이 늘어나야 한다.',
    '6~8문단에서 중산층 노인의 주택 부재를 지적하고 일본 사례와 전문가 의견을 통해 복합형 주택 확대를 강조하고 있습니다.',
    '마지막 문단에서 전문가가 제안하는 해결책이 무엇인지 읽어보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    3
),
-- 7. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"일붕실버랜드는 단순히 집만 제공하는 주거 기능에 머물지 않고, 병원과 요양원을 함께 운영하여 노인들의 (      ) 문제까지 한 번에 해결해 준다."',
    'multiple_choice',
    '["돌봄과 건강", "해외 유학", "자녀 교육", "자동차 수리"]'::json,
    '돌봄과 건강',
    '병원과 요양원이 연결되어 있어 건강 악화나 장기 케어가 필요한 시기의 돌봄을 해결해 준다는 문맥이 성립합니다.',
    '3문단에서 병원과 요양원이 연결되어 생기는 이점이 무엇인지 생각해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    3
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '2023년 조사에 따르면 경남 지역 노인 대부분은 건강이 나빠지더라도 자녀의 집으로 이사하는 것을 가장 선호함을 알 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '5문단에서 노인의 82.2%가 지금 사는 집에서 살기를 원했고, 가족과 함께 살겠다는 응답은 3.1%에 불과했습니다.',
    '5문단에 나온 2023년 노인실태조사의 응답 비율을 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    3
),
-- 9. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '기사의 내용을 논리적 흐름에 맞게 나열한 것은 무엇인가요?',
    'multiple_choice',
    '["경남 노인 주거의 현실 -> 두 실버타운 비교 -> 중산층 노인 주거 부족 문제 -> 해결 대안 제시", "해외 사례 소개 -> 경남 노인 주거 현실 -> 중산층 노인 주거 부족 문제 -> 두 실버타운 비교", "중산층 노인 주거 부족 문제 -> 두 실버타운 비교 -> 해외 사례 소개 -> 경남 노인 주거 현실", "두 실버타운 비교 -> 해외 사례 소개 -> 경남 노인 주거 현실 -> 중산층 노인 주거 부족 문제"]'::json,
    '경남 노인 주거의 현실 -> 두 실버타운 비교 -> 중산층 노인 주거 부족 문제 -> 해결 대안 제시',
    '기사는 지역 현황(1문단)으로 시작하여 사례 비교(2~4문단), 중산층 주택 부족 문제(6~7문단), 해외 사례 및 대안(8문단)으로 전개됩니다.',
    '글의 시작 부분인 경남 현황부터 마지막 대안 제시까지 문단별 핵심 내용을 차례대로 확인해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    3
),
-- 10. structure / structure_irrelevant_sentence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '다음 중 기사의 전체적인 흐름과 관련이 없는 문장은 무엇인가요?',
    'multiple_choice',
    '["요즘 초등학생들이 가장 받고 싶어 하는 명절 선물 1위는 학용품 세트이다.", "경남 노인가구 10곳 중 7곳 이상은 지어진 지 20년이 넘은 집에 산다.", "부산 라우어 시니어타운은 수영장과 영화관 등 화려한 시설을 갖추고 있다.", "일본에서는 주거와 돌봄을 함께 제공하는 주택이 빠르게 늘고 있다."]'::json,
    '요즘 초등학생들이 가장 받고 싶어 하는 명절 선물 1위는 학용품 세트이다.',
    '이 기사는 노인 주거 시설과 대책에 대해 다루고 있으므로 초등학생 명절 선물에 대한 문장은 흐름과 맞지 않습니다.',
    '노인 주거 문제라는 주제에서 벗어난 보기 문장을 찾아보세요.',
    'daily_solo',
    'structure',
    'structure_irrelevant_sentence',
    3
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] 경남 의령군에 있는 일붕실버랜드는 국내 초기 실버타운 가운데 하나로, 1996년 문을 연 뒤 30년 가까이 운영되고 있다. 시설이 화려해서가 아니라 믿고 살 수 있다는 점이 좋다.

[문제] 위 문단에서 ''실버타운''이 의미하는 집단/시설은 누구를 위한 곳인가요?',
    'multiple_choice',
    '["노인", "어린이", "군인", "대학생"]'::json,
    '노인',
    '실버타운은 은퇴한 노인들이 일상생활과 편의 서비스를 제공받으며 거주하는 주택 시설을 뜻합니다.',
    '문단에서 언급된 입주민들의 연령대와 거주 환경을 생각해 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    3
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] 예전에는 보호가 필요한 대상으로만 여겨지던 60~70대가 이제는 소비와 여가를 즐기는 세대로 바뀌었고, 자녀와 함께 사는 것보다 독립적으로 생활하기를 원한다.

[문제] 위 문단의 ''독립적으로''는 ''남에게 의존하지 않고 스스로''라는 뜻으로 바꿔 쓸 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''독립적''은 남에게 매이지 않거나 의존하지 않는 것을 뜻하므로 맞는 설명입니다.',
    '자녀와 떨어져 스스로 생활하려는 모습과 연결 지어 생각해 보세요.',
    'room',
    'vocab',
    'vocab_appropriateness',
    3
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] 부산 기장군 오시리아 관광단지에 있는 라우어 시니어타운에는 수영장과 피트니스센터, 공연장, 영화관 등이 갖춰져 있다. 다만 입주 비용은 수억 원대 보증금에 월 수백만 원 수준이다.

[문제] 라우어 시니어타운은 다양한 편의시설을 갖추고 있으며 입주 비용이 저렴한 편입니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '문단에 수억 원대 보증금과 월 수백만 원 수준으로 비용이 높다고 나와 있으므로 저렴하다는 설명은 틀립니다.',
    '문단의 마지막 문장에서 입주 비용 수준이 어떻게 나와 있는지 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    3
),
-- 14. info_extraction / info_evidence (short_answer, 한 단어)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] 정선남 이사장은 2001년 사회복지법인을 설립해 노인대학과 노인일자리 사업, 병원, 요양원을 차례로 만들었다. 지금은 실버타운과 병원, 요양원이 하나로 연결돼 있다.

[문제] 정선남 이사장이 설립한 사회복지법인을 통해 실버타운과 함께 하나로 연결된 시설은 어디인가요? (병원 또는 요양원 중 하나만 쓰세요)',
    'short_answer',
    '[]'::json,
    '병원',
    '문단을 보면 실버타운과 병원, 요양원이 하나로 연결되어 있다고 나와 있습니다.',
    '문단 마지막 문장에 실버타운과 연결되어 있다고 언급된 시설들을 찾아보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    3
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] 고령층은 병원과 대중교통 접근성이 좋은 도심이나 도심 근교를 가장 선호했고, 전용면적 47~79㎡ 규모를 원했다. 특히 24시간 간호사 배치와 응급출동 서비스 같은 의료 안전망을 중요하게 여겼다.

[문제] 이 문단이 주로 다루고 있는 핵심 주제는 무엇인가요?',
    'multiple_choice',
    '["고령층이 선호하는 주거 환경과 조건", "대중교통 요금을 인상해야 하는 이유", "병원 간호사의 근무 환경 개선 방법", "도심 지역 아파트 가격이 상승하는 이유"]'::json,
    '고령층이 선호하는 주거 환경과 조건',
    '이 문단은 고령층이 원하는 주택 위치, 크기, 의료 서비스 등 선호 조건을 설명하고 있습니다.',
    '문단에 나오는 위치, 면적, 간호사 배치 등이 무엇에 대한 요구 사항인지 생각해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    3
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] 해외에서는 이미 주거와 돌봄을 결합하는 방향으로 움직이고 있다. 일본의 ''서비스제공 고령자주택(사코주)''이 대표적인데, 독립적으로 생활할 수 있는 노인이 거주하면서 필요할 때 돌봄 서비스를 받는다.

[문제] 이 문단에 붙일 가장 적절한 제목은 무엇인가요?',
    'multiple_choice',
    '["주거와 돌봄을 결합한 해외 노인 주택 사례", "일본으로 여행을 떠나는 노인들의 증가", "돌봄 서비스가 불필요해진 고령화 사회", "독립 생활이 불가능한 노인들을 위한 시설"]'::json,
    '주거와 돌봄을 결합한 해외 노인 주택 사례',
    '문단 첫 문장과 일본 사코주 사례를 볼 때 주거와 돌봄이 결합된 해외 사례를 소개하는 제목이 가장 적절합니다.',
    '해외와 일본의 사코주 사례가 어떤 특징을 가졌는지 문단에서 찾아보세요.',
    'room',
    'core_understanding',
    'core_title',
    3
),
-- 17. inference_judgment / inference_blank (short_answer, 한 단어)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] 공공 주택은 저소득층 중심이고, 민간 시설은 고가 상품 위주다. 그래서 그 사이에 있는 ____ 노인을 위한 주거는 충분히 마련되지 않았다.

[문제] 문단의 빈칸에 들어갈 한 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '중산층',
    '기사 본문에서 저소득층과 고소득층 사이에 위치하여 주거 혜택을 받지 못하는 계층을 ''중산층''으로 설명합니다.',
    '저소득층과 고소득층 사이에 위치한 계층을 뜻하는 세 글자 단어를 적어보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    3
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] 경남 노인가구 10곳 가운데 7곳 이상은 지어진 지 20년이 넘은 집에 살고 있고, 노인을 위한 안전설비를 갖춘 집은 드물다. 그래서 기존 주택을 안전하게 고치는 정책이 필요하다.

[문제] 위 문단을 통해 추론할 수 있는 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["오래된 집에서 노인들이 넘어지거나 다칠 위험이 있다.", "경남의 노인들은 모두 최신 아파트에만 살고 있다.", "20년이 넘은 집은 즉시 다 부수고 새로 지어야만 한다.", "노인들은 집 안에 안전설비가 있는 것을 불편해한다."]'::json,
    '오래된 집에서 노인들이 넘어지거나 다칠 위험이 있다.',
    '지어진 지 20년이 넘고 안전설비가 드물기 때문에 안전사고 위험이 높아 고칠 필요성이 생김을 추론할 수 있습니다.',
    '안전설비가 드문 오래된 집에서 노인들이 겪을 수 있는 위험을 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    3
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] (A) 2023년 조사에서 경남 노인의 82.2%는 지금 사는 집에서 계속 살고 싶다고 답했다.
(B) 예전에는 보호 대상이던 노인이 이제는 독립적 생활을 원하는 세대로 바뀌었다.
(C) 반면 건강이 나빠져 노인전용주택으로 옮기겠다는 응답은 10.9%에 그쳤다.

[문제] 위 문장들을 자연스럽게 이어지도록 바르게 나열한 것은 무엇인가요?',
    'multiple_choice',
    '["(B) - (A) - (C)", "(A) - (B) - (C)", "(C) - (A) - (B)", "(B) - (C) - (A)"]'::json,
    '(B) - (A) - (C)',
    '노인의 세대 변화(B)를 먼저 제시한 후, 현 거주지 희망 비율(A)과 이에 대비되는 노인전용주택 희망 비율(C)로 이어지는 것이 자연스럽습니다.',
    '노인의 세대 변화 설명 뒤에 실태조사 응답 수치가 이어지는 흐름을 보세요.',
    'room',
    'structure',
    'structure_order',
    3
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '실버타운 간 앞집, 양로원 간 옆집…나는 어디로?'),
    '[문단] 일붕실버랜드는 30년 동안 운영될 수 있었다. [ ㄱ ] 주거 기능에만 머물지 않고 병원과 요양원을 차례로 만들었기 때문이다.

[문제] 문장의 [ ㄱ ] 위치에 들어갈 접속어로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["왜냐하면", "그러나", "하지만", "그러므로"]'::json,
    '왜냐하면',
    '앞 문장의 결과(30년 운영)에 대한 원인(병원·요양원 설립)을 뒤에서 설명하므로 ''왜냐하면''이 적절합니다.',
    '앞 문장에 대한 이유를 뒤 문장에서 설명할 때 쓰는 말을 찾아보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    3
);

-- 기사(''AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'')는 이미 DB에 있음(V6/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '다음 중 기사에 나온 ''중첩적''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["여러 가지 요인이나 현상이 겹쳐서 나타나는", "하나의 이유만으로 명확하게 설명되는", "시간이 지나면서 자연스럽게 사라지는", "서로 반대되는 영향이 맞아떨어지는"]'::json,
    '여러 가지 요인이나 현상이 겹쳐서 나타나는',
    '''중첩적''은 여러 요인이나 현상이 서로 겹쳐서 일어나는 것을 의미합니다.',
    '1문단에서 여러 원인이 한꺼번에 작용하는 맥락을 읽어보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    5
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '기사의 "공교육 내 문해력 체질 개선이 선행돼야 한다는"에서 ''선행돼야''와 의미가 가장 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["먼저 이루어져야", "나중에 미뤄져야", "동시에 진행돼야", "완전히 삭제돼야"]'::json,
    '먼저 이루어져야',
    '''선행되다''는 다른 일에 앞서 먼저 행해진다는 뜻이므로 ''먼저 이루어져야''와 같은 의미입니다.',
    '7문단에서 평가 방식을 바꾸기 전에 무엇을 먼저 해야 하는지 생각해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    5
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '한국언론진흥재단 조사에 따르면 중학생의 하루 평균 동영상 시청 시간은 초등학생과 고등학생보다 길었습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '3문단을 보면 중학생의 하루 평균 시청 시간은 233.7분으로 초등학생(143.6분)과 고등학생(226.2분)보다 길다고 명시되어 있습니다.',
    '3문단 중간에 나온 학년별 하루 평균 시청 시간 수치를 비교해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    5
),
-- 4. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '부산 대연중 하미숙 교사가 학생들에게 AI가 낸 답은 출처가 될 수 없다고 지도하는 근거는 무엇인가요?',
    'short_answer',
    '[]'::json,
    'AI가 내린 답이 늘 사실일 수는 없다',
    '4문단에서 하미숙 교사는 AI가 내린 답이 늘 사실일 수는 없다는 점을 근거로 지적했습니다.',
    '4문단에서 하미숙 교사의 인터뷰 인용문 내용을 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    5
),
-- 5. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '이 기사 전체에서 다루고 있는 핵심 주제는 무엇인가요?',
    'multiple_choice',
    '["디지털 환경 변화와 복합적 요인으로 인한 문해력 약화 현상 및 해결 과제", "생성형 AI 기술의 최신 발전 동향과 효율적인 질의 작성법", "코로나19 재유행을 예방하기 위한 공공 보건 수칙 안내", "사교육비를 줄이기 위한 정부의 새로운 대입 개편안"]'::json,
    '디지털 환경 변화와 복합적 요인으로 인한 문해력 약화 현상 및 해결 과제',
    '기사는 AI와 영상 매체, 팬데믹, 사교육 등 복합 요인으로 약화한 학생들의 문해력 현황과 공교육 대책의 필요성을 다룹니다.',
    '기사 제목과 각 문단에서 반복적으로 언급되는 문해력 약화 원인들을 종합해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    5
),
-- 6. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '이 기사의 중심 결론으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["평가 방식을 바꾸기에 앞서 공교육 내 문해력과 사고력을 강화하는 체질 개선이 선행되어야 한다.", "학생들의 디지털 기기 사용을 법적으로 전면 금지해야만 문해력이 회복될 수 있다.", "AI가 작성한 요약본을 수용하여 교과서 대신 활용하는 방안을 모색해야 한다.", "사교육을 대폭 확대하여 기초 학력이 부족한 학생들을 별도로 지도해야 한다."]'::json,
    '평가 방식을 바꾸기에 앞서 공교육 내 문해력과 사고력을 강화하는 체질 개선이 선행되어야 한다.',
    '마지막 문단에서 평가 방식 변경보다 공교육 내 문해력·사고력 중심의 교육 개편이 우선되어야 함을 강조하고 있습니다.',
    '7문단에 정리된 전문가들의 지적과 주장 내용을 읽어보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    5
),
-- 7. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"서무계 선임연구위원은 글을 직접 눈으로 읽고 쓸 일이 줄어들면 스스로 생각하고 이해하는 (      )이 사라져 AI 시대에 적응하기 어려워질 것이라고 경고했다."',
    'multiple_choice',
    '["자생력", "구매력", "면역력", "구속력"]'::json,
    '자생력',
    '글을 스스로 읽지 않으면 주도적인 읽기·생각 능력이 떨어지므로 ''자생력''이라는 표현이 맥락상 적절합니다.',
    '4문단 서무계 선임연구위원의 경고 발언 중 핵심 단어를 찾아보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    5
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '사교육에 지나치게 의존하면 학생들의 공교육 의존도가 낮아지고 기초가 부족한 학생의 학력 차이가 커질 수 있음을 추론할 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '6문단에서 사교육에 의존하면서 선행학습을 전제로 진도가 나가 기초가 없는 학생의 양극화가 심해진다는 진단을 통해 추론 가능합니다.',
    '6문단에서 사교육 중심 환경이 가져오는 양극화 문제를 읽어보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    5
),
-- 9. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '기사의 내용을 논리적 흐름에 따라 순서대로 나열한 것은 무엇인가요?',
    'multiple_choice',
    '["문해력 약화 원인(디지털 매체) -> 관련 실태 조사 -> 팬데믹 및 사교육 영향 -> 공교육 개편 필요성", "공교육 개편 필요성 -> 관련 실태 조사 -> 팬데믹 및 사교육 영향 -> 문해력 약화 원인(디지털 매체)", "팬데믹 및 사교육 영향 -> 문해력 약화 원인(디지털 매체) -> 공교육 개편 필요성 -> 관련 실태 조사", "관련 실태 조사 -> 공교육 개편 필요성 -> 문해력 약화 원인(디지털 매체) -> 팬데믹 및 사교육 영향"]'::json,
    '문해력 약화 원인(디지털 매체) -> 관련 실태 조사 -> 팬데믹 및 사교육 영향 -> 공교육 개편 필요성',
    '기사는 원인 제기(1문단)에서 실태 통계(2~3문단), 추가 요인 분석(5~6문단), 결론 및 대안(7문단) 순으로 논리가 전개됩니다.',
    '글의 시작 부분인 환경 변화 제시부터 마지막 대안 제안까지의 구조를 파악해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    5
),
-- 10. structure / structure_irrelevant_sentence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '다음 중 기사의 전체적인 흐름과 관련이 없는 문장은 무엇인가요?',
    'multiple_choice',
    '["최근 인기 쇼트폼 챌린지 음원이 음원 차트 상위권을 독점하고 있다.", "학생들이 글을 직접 읽기보다 AI 요약본을 먼저 찾아보는 비율이 높다.", "코로나19 시기 비대면 수업으로 인한 경험 제한이 문해력에 영향을 주었다.", "공교육 내에서 문해력과 사고력을 강화하는 교육 개편이 선행되어야 한다."]'::json,
    '최근 인기 쇼트폼 챌린지 음원이 음원 차트 상위권을 독점하고 있다.',
    '이 기사는 디지털 매체가 학생 문해력에 미친 영향을 다루므로 음원 차트 순위 관련 내용은 흐름에 맞지 않습니다.',
    '학생들의 학습 현황 및 문해력 문제와 무관한 보기를 골라보세요.',
    'daily_solo',
    'structure',
    'structure_irrelevant_sentence',
    5
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] 학생들의 문해력이 급격히 약화한 배경에는 인공지능(AI)과 쇼트폼 콘텐츠로 대표되는 읽기 환경의 근본적 변화가 자리하고 있다는 분석이 나온다.

[문제] 위 문단에서 ''문해력''이 의미하는 바로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["글을 읽고 이해하는 능력", "외국어를 빠르게 번역하는 능력", "컴퓨터 프로그램을 만드는 능력", "그림을 보고 바로 그려내는 능력"]'::json,
    '글을 읽고 이해하는 능력',
    '문해력은 글을 읽고 그 뜻을 바르게 이해하고 활용하는 능력을 말합니다.',
    '문단에서 AI나 읽기 환경 변화와 관련하여 쓰인 단어의 뜻을 파악해 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    5
),
-- 12. vocab / vocab_paraphrase (OX)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] 현장 교육자들은 이 같은 흐름이 심화하면서 학생들이 직접 글을 읽고 정보를 선별하는 경험 자체가 줄어들고 있다고 지적한다.

[문제] 위 문단의 ''선별하는''은 ''가려 뽑는''으로 바꿔 쓸 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''선별하다''는 알맞은 것을 골라 가려 뽑는다는 뜻이므로 ''가려 뽑는''과 같은 의미입니다.',
    '수많은 정보 중 필요한 것을 골라내는 행동을 나타낸 단어인지 확인해 보세요.',
    'room',
    'vocab',
    'vocab_paraphrase',
    5
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] 생성형 AI 이용률 역시 67.7%로 나타났으며, 이용 목적으로는 ''다양한 정보를 빠르게 얻기 위해서''라는 응답이 74.2%로 가장 많았다.

[문제] 청소년들이 생성형 AI를 이용하는 가장 큰 목적은 다양한 정보를 빠르게 얻기 위함입니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '문단에 생성형 AI 이용 목적 중 ''다양한 정보를 빠르게 얻기 위해서''가 74.2%로 가장 많았다고 명시되어 있습니다.',
    '문단 후반부에서 생성형 AI 이용 목적 비율 수치를 찾아보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    5
),
-- 14. info_extraction / info_evidence (short_answer, 한 단어)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] 초4~고3 응답자의 95.1%가 조사 직전 일주일간 온라인 동영상 플랫폼을 이용했으며, 하루 평균 시청 시간은 200.6분, 약 3시간 20분에 달했다.

[문제] 초4~고3 학생들의 하루 평균 온라인 동영상 플랫폼 시청 시간은 약 몇 시간 몇 분인가요?',
    'short_answer',
    '[]'::json,
    '3시간20분',
    '문단에서 하루 평균 시청 시간은 200.6분으로 약 3시간 20분에 달한다고 언급되어 있습니다.',
    '문단에서 숫자로 표기된 시청 시간과 괄호로 표시된 ''약 시간'' 표현을 확인해 보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    5
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] 코로나19 팬데믹 시기의 학습 결손 역시 문해력 저하를 심화시킨 요인으로 거론된다. 김양진 경희대 국어국문학 교수는 "현재 중·고생들이 초등학교를 다닐 때 코로나를 겪으면서 학교에서의 여러 경험들이 제한되고 문자를 이해하는 데 영향을 끼쳤다"고 분석했다.

[문제] 이 문단이 다루는 중심 소재는 무엇인가요?',
    'multiple_choice',
    '["코로나19 팬데믹이 문해력 저하에 미친 영향", "중·고등학생들의 새로운 학교 적응 방법", "초등학교 국어 교과서의 난이도 조절 방안", "비대면 백신 접종이 학생 건강에 미친 효과"]'::json,
    '코로나19 팬데믹이 문해력 저하에 미친 영향',
    '이 문단은 코로나19 시기 학교 경험 제한과 학습 결손이 문해력 저하의 주요 요인이 되었음을 설명합니다.',
    '문단 첫 문장에서 원인으로 지목한 사건이 무엇인지 찾아보세요.',
    'room',
    'core_understanding',
    'core_topic',
    5
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] 최근 설문조사에 따르면, 자녀가 숙제나 공부를 할 때 긴 글을 직접 읽기보다 AI나 인터넷 요약본을 먼저 찾아본다는 응답이 58.2%로 절반을 훌쩍 넘어섰다. 반면 그렇지 않다는 응답은 37.5%에 그쳤다.

[문제] 이 문단에 붙일 가장 적절한 제목은 무엇인가요?',
    'multiple_choice',
    '["긴 글 대신 AI 요약본에 의존하는 학생들의 현실", "인터넷 속도를 높이기 위한 학생들의 노력", "학부모들의 인터넷 설문조사 참여 방법", "숙제 양을 줄여주어야 하는 이유"]'::json,
    '긴 글 대신 AI 요약본에 의존하는 학생들의 현실',
    '문단은 과제나 공부를 할 때 긴 글 대신 AI 요약본을 먼저 찾는 학생 비율이 절반 이상임을 보여주고 있습니다.',
    '문단에서 가장 높은 비율(58.2%)을 차지한 학생들의 행태가 무엇인지 파악해 보세요.',
    'room',
    'core_understanding',
    'core_title',
    5
),
-- 17. inference_judgment / inference_blank (short_answer, 한 단어)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] 우리 사회는 대입에 집중되다 보니 점수 위주의 교육으로 흘러간다. 따라서 문해력과 사고력을 강화하는 미래지향적 ____ 과정으로 개편할 필요가 있다.

[문제] 문맥상 빈칸에 들어갈 한 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '교육',
    '기사 원문에서 점수 위주의 체계를 벗어나 문해력과 사고력을 높이는 미래지향적 ''교육'' 과정을 강조하고 있습니다.',
    '문단 마지막 문장에서 ''과정'' 앞에 붙어 있는 두 글자 단어를 찾아보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    5
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] 사교육을 통해 아이들이 이미 배웠을 거라고 간주하고, 학교에서 가르치는 질과 양도 낮아졌을 것이다. 진도는 계속 나가는데 기초가 없으니 뒤처지는 학생은 계속 뒤처지고, 양극화는 더욱 심해진다.

[문제] 위 문단을 통해 추론할 수 있는 문제점은 무엇인가요?',
    'multiple_choice',
    '["기초가 부족한 학생일수록 학교 수업을 따라가지 못해 격차가 커진다.", "사교육을 받는 학생들이 모두 우수한 성적을 거두게 된다.", "학교 선생님들의 수업 시간이 이전보다 현저히 줄어든다.", "모든 학생이 사교육 덕분에 기초 학력을 완벽히 갖추게 된다."]'::json,
    '기초가 부족한 학생일수록 학교 수업을 따라가지 못해 격차가 커진다.',
    '사교육을 전제로 수업이 진행되면 기초가 부족한 학생이 뒤처지면서 학습 양극화가 심해짐을 추론할 수 있습니다.',
    '문단 끝부분에 나온 ''뒤처지는 학생''과 ''양극화''라는 표현을 연결해 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    5
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] (A) 이에 따라 AI 시대를 살아가는 학생들의 자생력이 없어질 것이라는 경고가 나온다.
(B) 동영상을 통해 정보를 얻고 책도 읽어주는 시대이다 보니 눈으로 읽지 않는다.
(C) 그 결과 글을 읽고 쓸 일이 점점 줄어들고 있다.

[문제] 위 문장들을 논리적 순서에 맞춰 바르게 나열한 것은 무엇인가요?',
    'multiple_choice',
    '["(B) - (C) - (A)", "(A) - (B) - (C)", "(C) - (A) - (B)", "(B) - (A) - (C)"]'::json,
    '(B) - (C) - (A)',
    '눈으로 읽지 않는 환경(B) -> 글 읽고 쓸 일 저하(C) -> 자생력 상실 경고(A) 순으로 원인과 결과가 이어집니다.',
    '환경의 변화(B)가 초래한 결과(C)와 그에 따른 경고(A)의 흐름을 확인해 보세요.',
    'room',
    'structure',
    'structure_order',
    5
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'AI가 요약하고 영상이 설명하고… 디지털 늪에 빠져'),
    '[문단] 평가 방식 변경에 앞서 공교육 내 문해력 체질 개선이 선행돼야 한다. [ ㄱ ] 우리 사회는 대입에 집중되다 보니 점수 위주의 교육으로 흘러가고 있다.

[문제] [ ㄱ ] 위치에 문장 간 원인 및 이유를 나타내기 위해 들어가기 가장 적절한 연결어는 무엇인가요?',
    'multiple_choice',
    '["왜냐하면", "그러나", "그렇지만", "하지만"]'::json,
    '왜냐하면',
    '앞 문장의 주장에 대해 우리 사회가 대입·점수 위주로 흐르는 현재 상황이라는 원인을 제시하므로 ''왜냐하면''이 가장 적절합니다.',
    '앞 문장의 대책 필요성에 대해 뒤 문장이 그 이유나 배경을 설명하는지 확인해 보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    5
);

-- 기사(''유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'')는 이미 DB에 있음(V6/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '다음 중 기사에 나온 ''편취한''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["남을 속여 재물이나 이익을 빼앗은", "정당한 대가를 지불하고 구매한", "타인에게 성의껏 빌려준", "국가에 정식으로 세금을 납부한"]'::json,
    '남을 속여 재물이나 이익을 빼앗은',
    '''편취하다''는 남을 속여 재물이나 이익을 빼앗는 것을 의미합니다.',
    '4문단에서 항공료나 보험료를 부풀려 불법적으로 돈을 챙긴 맥락을 확인해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    5
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '기사의 "부패 청산과 자정 노력이 선행돼야 할 문제"에서 ''자정''과 뜻이 가장 가까운 표현은 무엇인가요?',
    'multiple_choice',
    '["스스로 부패나 오점을 깨끗이 씻어냄", "외부의 힘을 빌려 강제로 정단함", "한밤중 12시를 가리켜 지칭함", "문제를 숨기고 타협점을 찾아냄"]'::json,
    '스스로 부패나 오점을 깨끗이 씻어냄',
    '여기서의 ''자정(自淨)''은 스스로 깨끗하게 정화하여 바로잡는다는 뜻입니다.',
    '9문단에서 부패한 기관 내부에서 스스로 개혁하는 노력을 뜻함을 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    5
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '우즈베키스탄에서 한국으로 오는 노동자가 부담하는 송출료와 사전교육비 합계(약 235만 원)는 일본이나 이스라엘의 약 5배 수준입니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '5문단을 보면 한국 송출 비용(약 235만 원)은 일본·이스라엘(약 50만 원)의 약 5배 수준이라고 정확히 명시되어 있습니다.',
    '5문단 중간의 각국 송출 수수료 비교 수치를 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    5
),
-- 4. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '우즈베크 데노우 지역 주민 100여 명이 한국어 시험 합격 후 2차 시험에서 부당하게 탈락했던 사유(표면적 이유)는 무엇이었나요?',
    'short_answer',
    '[]'::json,
    '색맹',
    '7문단에서 주민들이 브로커에게 뒷돈을 주지 않았다는 이유로 ''색맹''이라는 표면적 명목을 붙여 부당 탈락시켰음이 나와 있습니다.',
    '7문단 중간의 신체검사 탈락 사유로 명시된 단어를 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    5
),
-- 5. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '이 기사 전체에서 다루고 있는 핵심 주제는 무엇인가요?',
    'multiple_choice',
    '["고용허가제 관리 부실과 송출국 비리로 인한 이주노동자 피해 실태 및 제도적 개선 과제", "한국어 능력 시험의 난이도 조정과 외국인 출입국 절차의 간소화 방안", "우즈베키스탄 대외노동이주청의 설립 역사와 기관 내 주요 업무 소개", "유럽 및 아랍권 국가들의 외국인 인력 수급 정책 및 민간 알선업체 비교"]'::json,
    '고용허가제 관리 부실과 송출국 비리로 인한 이주노동자 피해 실태 및 제도적 개선 과제',
    '기사 전체는 방치된 고용허가제 아래에서 발생하는 송출 비리, 높은 수수료, 이주노동자 피해 및 감독 강화 필요성을 종합적으로 다룹니다.',
    '제목과 본문 전체에서 지속적으로 지적하는 한국 고용허가제의 구조적 문제와 피해를 생각해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    5
),
-- 6. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '이 기사가 궁극적으로 전하고자 하는 핵심 메시지는 무엇인가요?',
    'multiple_choice',
    '["정부가 고용허가제 관리·감독을 강화하고 송출 부패 및 과도한 수수료를 근본적으로 개선해야 한다.", "고용허가제를 폐지하고 모든 이주노동자 송출을 민간 알선업체에 완전히 위임해야 한다.", "우즈베키스탄 노동자의 한국 입국을 전면 금지하여 체류 불법화를 막아야 한다.", "외국인 노동자의 송출 수수료를 현재보다 2배 이상 인상하여 행정 비용을 충당해야 한다."]'::json,
    '정부가 고용허가제 관리·감독을 강화하고 송출 부패 및 과도한 수수료를 근본적으로 개선해야 한다.',
    '기사는 방치된 고용허가제의 구조적 부패와 높은 수수료 문제를 지적하며 엄격한 관리·감독 및 제도 개선을 촉구하고 있습니다.',
    '8~9문단에서 지적된 제도적 양면성과 이에 대응하는 관리 감독 필요성을 읽어보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    5
),
-- 7. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"비싼 송출료로 인해 빚을 진 이주노동자는 월급이 조금이라도 높은 일자리로 이동하려 하므로, 결국 고용허가제의 방치는 노동자뿐만 아니라 (      )에게도 손해로 이어진다."',
    'multiple_choice',
    '["사용자", "민간 브로커", "송출국 공무원", "항공사"]'::json,
    '사용자',
    '8문단에서 빚 스트레스로 인해 이탈이나 사업장 이동이 발생하므로 고용주(사용자)에게도 손해가 발생한다고 지적합니다.',
    '8문단 중반에서 노동자의 이탈이 누구의 손해로 연결되는지 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    5
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '송출 절차를 민간 업체에 전면 개입시키더라도 중간착취와 과도한 수수료 문제가 자연스럽게 해결될 것이라고 보기는 어렵습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '9문단에서 정영섭 집행위원이 민간 알선업체가 개입하는 비자(E-8, E-7)에서 중간착취와 브로커 폐해가 훨씬 심각하다고 반박한 점을 통해 추론할 수 있습니다.',
    '9문단 정영섭 집행위원의 인터뷰 내용 및 민간 개입 비자의 사례를 참고하세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    5
),
-- 9. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '기사의 내용 전개 순서를 바르게 나열한 것은 무엇인가요?',
    'multiple_choice',
    '["송출국 비리와 고용허가제 문제 지적 -> 과도한 송출 수수료 실태 -> 브로커 개입 피해 사례 -> 제도 개선 방안 논의", "제도 개선 방안 논의 -> 브로커 개입 피해 사례 -> 과도한 송출 수수료 실태 -> 송출국 비리와 고용허가제 문제 지적", "과도한 송출 수수료 실태 -> 송출국 비리와 고용허가제 문제 지적 -> 제도 개선 방안 논의 -> 브로커 개입 피해 사례", "브로커 개입 피해 사례 -> 제도 개선 방안 논의 -> 송출국 비리와 고용허가제 문제 지적 -> 과도한 송출 수수료 실태"]'::json,
    '송출국 비리와 고용허가제 문제 지적 -> 과도한 송출 수수료 실태 -> 브로커 개입 피해 사례 -> 제도 개선 방안 논의',
    '기사는 송출국 비리와 문제 제기(1~4문단) 후 수수료 수치(5~6문단), 브로커 피해사례(7~8문단), 마지막으로 제도 개선 논의(9~10문단)로 전개됩니다.',
    '글의 도입부 문제 제기부터 마지막 대안 및 해명까지 흐름을 짚어보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    5
),
-- 10. structure / structure_irrelevant_sentence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '다음 중 기사의 전체적인 내용 흐름과 무관한 문장은 무엇인가요?',
    'multiple_choice',
    '["최근 해외 관광객 감소로 인해 저비용 항공사들의 국외 노선 운항이 축소되고 있다.", "우즈베키스탄 이주청 관계자들이 불법 자금을 받아 구속되는 사건이 반복되었다.", "한국의 고용허가제 송출료는 유럽이나 다른 국가들에 비해 유독 비싼 편이다.", "정부 기관이 독점하는 인력 송출 구조는 부패 시 견제하기 어렵다는 양면성이 있다."]'::json,
    '최근 해외 관광객 감소로 인해 저비용 항공사들의 국외 노선 운항이 축소되고 있다.',
    '본 기사는 이주노동자 고용허가제 및 송출 비리를 다루고 있으므로 관광객 감소와 저비용 항공사 노선 축소 문장은 흐름에서 벗어납니다.',
    '이주노동자 및 고용허가제와 상관없는 문장을 찾아보세요.',
    'daily_solo',
    'structure',
    'structure_irrelevant_sentence',
    5
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] 송출기관의 불법 행위나 인권침해, 브로커 개입으로 노동자들이 겪는 피해는 오랫동안 관리감독의 사각지대에 놓여 있었다.

[문제] 위 문단에서 ''사각지대''가 뜻하는 바로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["관심이나 영향이 미치지 못하는 구역이나 범위", "네 모서리가 직각으로 이루어진 안전한 공간", "사건·사고가 빈번하게 발생하는 위험 지역", "정부의 혜택이 집중되어 가장 먼저 지원받는 곳"]'::json,
    '관심이나 영향이 미치지 못하는 구역이나 범위',
    '''사각지대''는 어떤 대상이나 관심이 미치지 못하여 방치되는 영역을 비유적으로 이르는 말입니다.',
    '문단에서 관리감독이 제대로 이루어지지 않고 방치되었다는 표현과 연결해 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    5
),
-- 12. vocab / vocab_paraphrase (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] 2019년 라브샨 이브라기모프 전 이주청장은 다른 공무원과 공모해 최소 400명에게 한국 취업을 약속하고 불법 자금을 받은 혐의로 징역을 선고받았다.

[문제] 위 문단의 ''공모해''는 ''함께 꾀를 모아''라는 뜻으로 바꾸어 쓸 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''공모하다''는 두 사람 이상이 불법적인 일을 함께 도모한다는 뜻이므로 ''함께 꾀를 모아''로 바꿀 수 있습니다.',
    '공무원과 함께 짜고 범죄를 저질렀다는 문맥을 고려해 보세요.',
    'room',
    'vocab',
    'vocab_paraphrase',
    5
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] 유럽과 러시아, 아랍권 국가들은 한국과 달리 노동자가 일하러 갈 때 수수료가 아예 없다.

[문제] 유럽, 러시아, 아랍권 국가에서는 해외 취업 시 수수료를 전혀 내지 않습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '5문단 후반부에 "유럽과 러시아, 아랍권 국가들은 아예 수수료가 없다"고 밝히고 있습니다.',
    '5문단에서 유럽, 러시아, 아랍권 국가의 수수료 존재 여부를 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    5
),
-- 14. info_extraction / info_evidence (short_answer, 한 단어)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] 영국의 소규모 공급업자 및 노동착취방지청(GLAA)은 지난해 우즈벡 농업노동자 모집 과정에서 협약상 허가되지 않은 민간업체가 개입한 사실이 확인되자 관련 양해각서 효력을 어떻게 조치했나요?',
    'short_answer',
    '[]'::json,
    '일시중단',
    '9문단 마지막 문장에서 영국 GLAA는 불법 민간업체 개입이 확인되자 양해각서 효력을 ''일시 중단''했다고 밝힙니다.',
    '9문단 맨 끝에 나온 영국의 대응 조치 단어를 찾아보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    5
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] 정부 기관이 인력 송출을 독점하는 구조는 민간 브로커 개입은 막을 수 있지만, 그 기관 자체가 부패할 경우 이를 견제할 장치가 마땅치 않다는 양면성을 지닌다. 이 때문에 더 엄격한 관리 감독이 필요하다는 지적이 나온다.

[문제] 위 문단의 중심 소재는 무엇인가요?',
    'multiple_choice',
    '["정부 독점 인력 송출 구조가 지닌 양면성과 관리 감독의 필요성", "민간 알선업체를 전면 허용했을 때 얻을 수 있는 경제적 이득", "외국인 노동자의 국내 적응을 돕기 위한 사회적 지원 체계", "부패 공무원을 처벌하기 위한 사법 제도의 개혁 방안"]'::json,
    '정부 독점 인력 송출 구조가 지닌 양면성과 관리 감독의 필요성',
    '이 문단은 정부 기관 독점 구조가 가진 장점과 부패 견제 어려움이라는 양면성, 그리고 감독 강화 필요성을 핵심으로 삼고 있습니다.',
    '문단에 명시된 ''양면성''과 ''엄격한 관리 감독''이라는 키워드를 떠올려 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    5
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] 비싼 송출료 때문에 자산을 팔거나 빚을 지고 입국한 이주노동자는 빚 스트레스를 안고 일을 시작하며, 월급이 조금이라도 높은 일자리가 나타나면 규정 위반을 감수하고서라도 사업장을 옮기려 한다. 이는 결국 사용자 쪽 손해로도 이어진다.

[문제] 이 문단의 내용과 가장 잘 어울리는 제목은 무엇인가요?',
    'multiple_choice',
    '["과도한 송출료의 부작용: 노동자 고통과 사업장 이탈 위험", "외국인 노동자들의 고득점 취업 성공 비결", "사업장 변경을 법적으로 완벽히 차단하는 방법", "이주노동자의 국내 월급 수준과 적금 저축 비율"]'::json,
    '과도한 송출료의 부작용: 노동자 고통과 사업장 이탈 위험',
    '문단은 비싼 송출료가 노동자에게 빚 부담을 주고 사업장 이탈을 부추겨 고용주에게도 피해를 준다는 점을 설명합니다.',
    '문단 전체가 송출료 부담이 불러오는 부작용과 그로 인한 사업장 옮김 현상을 말하고 있음을 확인해 보세요.',
    'room',
    'core_understanding',
    'core_title',
    5
),
-- 17. inference_judgment / inference_blank (short_answer, 한 단어)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] 양해각서에는 지나치게 높은 수수료가 책정될 경우 한국 정부가 송출기관에 수수료 인하를 요청할 수 있다는 조항이 있다. 그러나 한국 산업인력공단에 송출료 개선을 요청하는 메일을 보냈음에도 ____을 받지 못했다.

[문제] 문맥상 빈칸에 들어갈 두 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '답변',
    '원문 6문단에서 공단 측에 송출료 개선 요청 메일을 보냈으나 ''답변''을 받지 못했다고 밝히고 있습니다.',
    '6문단 중간에서 공단이 취한 반응(무응답)을 뜻하는 단어를 찾아보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    5
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] 우즈벡 이주청은 과도한 송출료 논란에 대해 "현재 수수료 책정 사안을 재검토 중이며, 서비스 가격을 실제 원가에 맞게 조정하는 것이 목적"이라고 해명했다. 다만 한국 고용노동부와 한국산업인력공단은 관련 질의에 대한 답변을 내놓지 않았다.

[문제] 위 문단을 통해 알 수 있는 한국 노동당국의 태도로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["송출 수수료 문제와 관련해 소극적이거나 침묵하는 태도를 보이고 있다.", "즉각적인 수수료 인하 정책을 발표하며 적극적으로 대응하고 있다.", "우즈베키스탄 이주청의 수수료 재검토 조치를 강력히 반대하고 있다.", "송출 비리 문제를 해결하기 위해 경찰과 합동 수사를 개시했다."]'::json,
    '송출 수수료 문제와 관련해 소극적이거나 침묵하는 태도를 보이고 있다.',
    '송출국 이주청의 해명과 달리 한국 고용노동부와 공단은 질의에 무답변으로 일관했다는 점에서 소극적 태도를 알 수 있습니다.',
    '문단 마지막 문장의 한국 기관들의 무답변 태도를 주목해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    5
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] (A) 이로 인해 브로커에게 뒷돈을 주지 않은 응시자들이 억울하게 탈락하는 사건이 일어났다.
(B) 고용허가제는 정부 기관이 인력을 관리해 브로커 개입을 막도록 설계된 제도이다.
(C) 하지만 제도 도입 20년 동안 인력 매매 비리가 이 제도를 계속 파고들었다.

[문제] 의미상 가장 자연스러운 논리적 순서로 나열한 것은 무엇인가요?',
    'multiple_choice',
    '["(B) - (C) - (A)", "(A) - (B) - (C)", "(C) - (A) - (B)", "(B) - (A) - (C)"]'::json,
    '(B) - (C) - (A)',
    '제도의 본래 목적(B) -> 본래 목적과 달리 파고든 비리(C) -> 그로 인한 구체적 피해 사례(A) 순으로 전개되는 것이 자연스럽습니다.',
    '제도 설계 취지(B) 뒤에 역설적 상황(C)과 구체적 사건(A)이 배치되는 구조를 확인해 보세요.',
    'room',
    'structure',
    'structure_order',
    5
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '유럽은 ''0원''인데…일하러 가는데 돈 내야 하는 한국, ''방치된'' 고용허가제'),
    '[문단] 심각한 불법·반인권 사안에는 송출 인원 축소나 일시 중단 같은 단호한 조치가 필요하다. [ ㄱ ] 영국의 한 기관은 우즈벡 농업노동자 모집 과정에서 허가되지 않은 민간업체가 개입하자 양해각서 효력을 일시 중단한 바 있다.

[문제] [ ㄱ ] 위치에 들어갈 상응하는 사례 연결어로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["실제로", "그러나", "반면에", "하지만"]'::json,
    '실제로',
    '앞 문장의 단호한 조치 필요성에 대한 구체적 실증 사례로 영국의 조치를 소개하고 있으므로 ''실제로''가 가장 적절합니다.',
    '앞 문장의 주장을 받쳐주는 구체적 외국 사례가 등장함을 파악해 보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    5
);

-- 기사(''오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '기사에 등장한 ''특화''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["특정한 분야나 용도에 맞게 구별하거나 발달시키는 것", "여러 기능을 하나로 합쳐서 간단하게 만드는 것", "가격을 크게 낮추어 많은 사람에게 파는 것", "오래된 시스템을 새로 교체하여 폐기하는 것"]'::json,
    '특정한 분야나 용도에 맞게 구별하거나 발달시키는 것',
    '''특화''는 특정 목적이나 대상에 적합하도록 전용화하거나 전문화하는 것을 뜻합니다.',
    '1문단과 2문단에서 금융 업무에 맞춰 제품을 만들었다는 의미를 생각해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    1
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '기사의 "근거를 바탕으로 결론을 뒷받침할 수 있도록"에서 ''뒷받침할''과 뜻이 가장 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["보증할", "반박할", "축소할", "취소할"]'::json,
    '보증할',
    '''뒷받침하다''는 어떠한 의견이나 결론이 들어맞도록 이치나 증거를 대어 든든하게 받쳐주는 것을 의미하므로 ''보증하다'' 또는 ''지지하다''와 맥락이 가장 가깝습니다.',
    '3문단에서 결론을 더욱 확실하고 튼튼하게 만들어 준다는 뜻을 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    1
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '오픈AI의 최고재무책임자(CFO)는 최근 소비자용 사업 매출이 기업용 사업 매출을 넘어섰다고 밝혔습니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '5문단에 따르면 새러 프라이어 CFO는 기업용 사업 매출이 소비자용 사업 매출을 넘어섰다고 밝혔습니다.',
    '5문단 마지막 문장에서 기업용 사업 매출과 소비자용 사업 매출 중 어느 쪽이 더 높은지 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '닉 털리 부사장이 시연에서 챗GPT를 활용해 보여준 작업으로 옳지 않은 것은 무엇인가요?',
    'multiple_choice',
    '["실시간으로 주식 가격을 직접 매매하여 거래하기", "잠재적인 인수·합병(M&A) 대상 기업 분석하기", "금융정보업체 자료에서 재무 수치 가져오기", "지정된 스타일 지침에 맞춰 파워포인트 자료 제작하기"]'::json,
    '실시간으로 주식 가격을 직접 매매하여 거래하기',
    '4문단 시연 내용에는 M&A 대상 분석, 재무 수치 수집, 파워포인트 자료 제작이 언급되었으며 직접 주식을 매매하는 기능은 언급되지 않았습니다.',
    '4문단에서 시연을 통해 직접 공개된 기능 3가지를 읽어보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    1
),
-- 5. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '이 기사 전체에서 중심으로 다루고 있는 주제는 무엇인가요?',
    'multiple_choice',
    '["오픈AI의 금융 업무 특화 챗GPT 출시와 기업용 시장 확대 행보", "인구 감소에 따른 금융회사의 오프라인 지점 축소 문제", "개인 투자자를 위한 무료 주식 리서치 모바일 앱 소개", "파워포인트 프로그램을 사용해 발표 자료를 만드는 방법"]'::json,
    '오픈AI의 금융 업무 특화 챗GPT 출시와 기업용 시장 확대 행보',
    '기사는 오픈AI가 금융업에 특화된 AI 서비스를 출시하고 이를 통해 기업용 AI 시장을 확대하려 한다는 내용을 다루고 있습니다.',
    '기사 제목과 첫 번째 문단에서 어떤 새로운 제품이 출시되었는지 확인해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    1
),
-- 6. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '이 기사가 전달하려는 핵심 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["오픈AI는 금융업에 특화된 AI를 통해 기업용 AI 시장에서의 입지를 강화하려 한다.", "금융회사들은 AI 도입으로 인해 모든 애널리스트를 해고하기로 결정했다.", "소비자용 챗GPT의 매출이 급감하여 오픈AI가 파산 위기에 처했다.", "금융 정보의 보안 문제로 인해 AI 서비스 사용이 전면 금지되었다."]'::json,
    '오픈AI는 금융업에 특화된 AI를 통해 기업용 AI 시장에서의 입지를 강화하려 한다.',
    '오픈AI가 금융 특화 챗GPT를 출시한 배경에는 기업용 매출 성장에 힘입어 기업용 AI 시장 영역을 넓히려는 목적이 있습니다.',
    '5문단에서 이번 신제품 출시가 오픈AI의 사업 방향과 어떻게 연결되는지 생각해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    1
),
-- 7. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"오픈AI는 단순한 대화형 AI를 넘어 전문가 수준의 리서치와 자료 작성을 지원함으로써, 기업 고객이 AI를 업무에 더욱 (      ) 도입하도록 유도하고 있다."',
    'multiple_choice',
    '["적극적으로", "소극적으로", "부정적으로", "드물게"]'::json,
    '적극적으로',
    '전문가 업무 지원 기능이 향상되면 기업 고객이 더 편리함을 느껴 AI를 적극적으로 도입하게 됩니다.',
    '기업용 AI 서비스의 기능이 고도화될 때 기업들의 이용 태도가 어떻게 변화할지 추론해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    1
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '금융서비스용 챗GPT를 활용하면 금융 회사 직원들의 자료 조사 및 보고서 작성 시간이 단축될 것임을 추론할 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '재무 수치 수집부터 파워포인트 제작까지 자동으로 지원하므로 업무 시간을 아끼는 데 도움을 줄 것임을 알 수 있습니다.',
    '2문단과 4문단에 제시된 챗GPT의 자동화된 지원 기능을 참고해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    1
),
-- 9. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '기사의 내용 전개 순서로 가장 바르게 연결된 것은 무엇인가요?',
    'multiple_choice',
    '["신제품 출시 소식 -> 주요 기능 설명 -> 시연 내용 공개 -> 출시의 사업적 배경 및 의미", "주요 기능 설명 -> 시연 내용 공개 -> 신제품 출시 소식 -> 출시의 사업적 배경 및 의미", "출시의 사업적 배경 및 의미 -> 신제품 출시 소식 -> 시연 내용 공개 -> 주요 기능 설명", "시연 내용 공개 -> 주요 기능 설명 -> 출시의 사업적 배경 및 의미 -> 신제품 출시 소식"]'::json,
    '신제품 출시 소식 -> 주요 기능 설명 -> 시연 내용 공개 -> 출시의 사업적 배경 및 의미',
    '기사는 금융서비스용 챗GPT 출시(1문단) -> 지원 기능(2~3문단) -> 시연 예시(4문단) -> 기업용 시장 확대 배경(5문단)으로 전개됩니다.',
    '1문단의 제품 공개 발표부터 마지막 문단의 매출 성과 및 사업 의미까지 순서를 파악해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    1
),
-- 10. structure / structure_irrelevant_sentence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '다음 중 기사의 전체 흐름과 가장 관련이 없는 문장은 무엇인가요?',
    'multiple_choice',
    '["올해 여름 휴가철 동안 해외 여행객 수가 역대 최대치를 기록했다.", "오픈AI가 금융회사 업무에 특화한 신규 AI 서비스를 출시했다.", "금융서비스용 챗GPT는 기업 자료 분석과 리서치 노트 작성을 지원한다.", "오픈AI는 기업용 AI 시장에서 사업 영역을 확대하려는 행보를 보이고 있다."]'::json,
    '올해 여름 휴가철 동안 해외 여행객 수가 역대 최대치를 기록했다.',
    '이 기사는 오픈AI의 금융 특화 AI 출시 소식에 관한 글이므로 해외 여행객 수에 대한 문장은 글의 흐름에 맞지 않습니다.',
    '오픈AI 및 AI 서비스 출시와 무관한 내용을 골라보세요.',
    'daily_solo',
    'structure',
    'structure_irrelevant_sentence',
    1
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] 털리 부사장은 이날 시연에서 챗GPT를 활용해 잠재적인 인수·합병(M&A) 대상 기업을 분석하는 모습을 공개했다.

[문제] 위 문단에서 ''인수·합병(M&A)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["한 기업이 다른 기업의 경영권을 얻거나 둘 이상의 기업이 하나로 합쳐지는 것", "기업이 제품의 가격을 올려 소비자에게 판매하는 행위", "새로운 직원을 채용하기 위해 면접을 진행하는 과정", "회사 내부의 인적 자원을 외부로 매각하는 절차"]'::json,
    '한 기업이 다른 기업의 경영권을 얻거나 둘 이상의 기업이 하나로 합쳐지는 것',
    '인수·합병(M&A)은 기업 구매(인수)와 합치기(합병)를 뜻하는 경영 용어입니다.',
    '문단에서 기업 분석 대상으로 제시된 M&A가 어떠한 기업 간 결합인지 생각해 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    1
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] 금융서비스용 챗GPT는 기업·산업·시장 조사부터 실적 발표와 기업 자료 분석, 리서치 노트 작성까지 금융 업무 전반을 지원한다.

[문제] 위 문단의 ''전반''을 ''일부''라는 단어로 바꾸어 써도 자연스러우며 의미가 변하지 않습니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '''전반''은 전체에 걸친 범위를 뜻하므로, 제한된 영역만을 뜻하는 ''일부''로 바꾸면 전체를 지원한다는 본래 의미가 훼손됩니다.',
    '''전반''이 전체 범위를 나타내는지, 일부만을 나타내는지 비교해 보세요.',
    'room',
    'vocab',
    'vocab_appropriateness',
    1
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] 오픈AI가 10일(현지시각) 금융회사 업무에 특화한 인공지능(AI) 서비스 ''금융서비스용 챗GPT''를 출시했다. 금융서비스용 챗GPT는 기업용 서비스인 ''챗GPT 워크''를 투자은행(IB)과 주식 리서치 업무에 맞게 특화한 제품이다.

[문제] 금융서비스용 챗GPT는 기업용 서비스인 ''챗GPT 워크''를 바탕으로 만든 제품입니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '문단에 "기업용 서비스인 ''챗GPT 워크''를 투자은행(IB)과 주식 리서치 업무에 맞게 특화한 제품이다"라고 나와 있습니다.',
    '문단 두 번째 문장에서 어떤 기존 서비스를 바탕으로 특화되었는지 읽어보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    1
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] 털리 부사장은 이날 시연에서 챗GPT를 활용해 잠재적인 인수·합병(M&A) 대상 기업을 분석하는 모습을 공개했다. 챗GPT는 LSEG와 피치북 등 금융정보업체의 자료에서 재무 수치를 가져오고, 사전에 지정된 스타일 지침에 맞춰 파워포인트 자료까지 제작했다.

[문제] 챗GPT가 시연 중 재무 수치를 가져온 금융정보업체 두 곳 중 하나를 쓰세요.',
    'short_answer',
    '[]'::json,
    'LSEG',
    '문단에서 언급된 금융정보업체는 ''LSEG''와 ''피치북''입니다.',
    '문단에서 재무 수치를 가져온 출처로 명시된 금융정보업체 이름을 찾아보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    1
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] 닉 털리 오픈AI 부사장 겸 챗GPT 부문장은 신제품 공개 행사에서 "챗GPT가 애널리스트처럼 조사하고, 근거를 바탕으로 결론을 뒷받침할 수 있도록 훈련하고 있다"고 말했다.

[문제] 위 문단에서 닉 털리 부사장이 강조하고 있는 챗GPT의 개발 방향은 무엇인가요?',
    'multiple_choice',
    '["전문 애널리스트처럼 조사하고 근거 있는 결론을 도출하는 능력", "인터넷 소설을 사람보다 더 자연스럽게 써내는 창작 능력", "사람과 간단한 일상 대화를 나누며 친밀감을 쌓는 대화 능력", "컴퓨터 그래픽 게임을 스스로 설계하고 구현하는 프로그래밍 능력"]'::json,
    '전문 애널리스트처럼 조사하고 근거 있는 결론을 도출하는 능력',
    '닉 털리 부사장은 챗GPT가 애널리스트 수준의 조사와 근거 기반 결론 도출을 하도록 훈련 중이라고 강조했습니다.',
    '인용문 안에서 챗GPT가 누구처럼 조사하도록 훈련받는지 확인해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    1
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] 이번 제품 출시는 기업공개(IPO)를 준비 중인 오픈AI가 기업용 AI 시장에서 사업 영역을 확대하려는 행보로 풀이된다. 새러 프라이어 오픈AI 최고재무책임자(CFO)는 지난달 기업용 사업 매출이 소비자용 사업 매출을 넘어섰다고 밝힌 바 있다.

[문제] 이 문단의 내용과 가장 잘 어울리는 제목은 무엇인가요?',
    'multiple_choice',
    '["기업용 AI 시장으로 영토 넓히는 오픈AI", "소비자용 AI 매출 급격한 성장세 기록", "기업공개(IPO)를 철회하고 나선 오픈AI", "최고재무책임자(CFO)의 전격 사임 소식"]'::json,
    '기업용 AI 시장으로 영토 넓히는 오픈AI',
    '문단은 오픈AI가 기업용 사업의 호조를 바탕으로 기업용 AI 시장 영역을 넓히고 있다고 설명합니다.',
    '기업용 사업 매출이 성장함에 따라 오픈AI가 취하는 전략적 행보를 나타내는 제목을 골라보세요.',
    'room',
    'core_understanding',
    'core_title',
    1
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] 오픈AI는 금융회사 업무에 특화한 서비스를 선보였다. 이를 통해 단순 소비자용 시장을 넘어 기업 고객을 대상으로 한 ____ 사업 매출을 더욱 늘리려는 의도를 알 수 있다.

[문제] 문맥상 빈칸에 들어갈 두 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '기업',
    '기사 본문에 따르면 소비자용 사업보다 ''기업''용 사업 매출이 늘어나고 있으며 이를 확대하려 합니다.',
    '5문단에서 소비자용 사업과 비교되어 강조된 사업 분야 단어를 찾아보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    1
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] 챗GPT는 LSEG와 피치북 등 금융정보업체의 자료에서 재무 수치를 가져오고, 사전에 지정된 스타일 지침에 맞춰 파워포인트 자료까지 제작했다.

[문제] 위 문단을 바탕으로 알 수 있는 챗GPT의 핵심 강점은 무엇인가요?',
    'multiple_choice',
    '["여러 외부 데이터 수집부터 문서 시각화까지 연계하여 처리할 수 있다.", "모든 수식을 사람보다 무조건 정확하게 검증해 낼 수 있다.", "컴퓨터 전원이 꺼져 있어도 스스로 작동할 수 있다.", "금융정보업체의 자료를 결제하지 않고 무단으로 가져올 수 있다."]'::json,
    '여러 외부 데이터 수집부터 문서 시각화까지 연계하여 처리할 수 있다.',
    '외부 정보 업체의 수치를 수집하는 작업과 이를 양식에 맞는 파워포인트로 시각화하는 작업을 연계 처리함을 보여줍니다.',
    '데이터를 가져와 보고서 양식(파워포인트)으로 만드는 연속적인 과정을 떠올려 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    1
),
-- 19. structure / structure_order (multiple_choice) — 원본은 선택지 2개였으나 규칙(4개)에 맞춰 문장 하나 추가해 재구성
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] (A) 새러 프라이어 오픈AI CFO는 기업용 사업 매출이 소비자용 사업 매출을 넘어섰다고 밝혔다.
(B) 이번 제품 출시는 기업공개(IPO)를 준비 중인 오픈AI가 기업용 AI 시장을 확대하려는 행보로 풀이된다.
(C) 오픈AI는 금융회사 업무에 특화한 새로운 AI 서비스를 출시했다.

[문제] 세 문장을 논리적으로 자연스럽게 이어지도록 나열한 것은 무엇인가요?',
    'multiple_choice',
    '["(C) - (B) - (A)", "(A) - (B) - (C)", "(B) - (A) - (C)", "(C) - (A) - (B)"]'::json,
    '(C) - (B) - (A)',
    '출시 사실(C)을 먼저 알리고, 이를 시장 확대 행보로 해석(B)한 뒤, 이를 뒷받침하는 매출 근거(A)를 제시하는 순서가 자연스럽습니다.',
    '사실 전달 -> 의미 해석 -> 근거 제시 순서로 이어지는 흐름을 확인해 보세요.',
    'room',
    'structure',
    'structure_order',
    1
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오픈AI, 금융사 특화 챗GPT 출시…주식 리서치·M&A 분석 지원'),
    '[문단] 챗GPT가 애널리스트처럼 조사하고 결론을 뒷받침하도록 훈련하고 있다. [ ㄱ ] 시연에서는 M&A 대상 기업을 분석하고 파워포인트 자료까지 제작하는 기능이 공개되었다.

[문제] [ ㄱ ] 위치에 들어갈 연결어로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["실제로", "그러나", "반면에", "하지만"]'::json,
    '실제로',
    '앞 문장의 훈련 방향을 보여주기 위해 구체적인 시연 사례를 연결하고 있으므로 ''실제로''가 가장 적절합니다.',
    '앞 문장의 설명이 뒤 문장에서 구체적 시연 사례로 증명되는 흐름을 파악해 보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    1
);

-- 기사(''"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.
-- 참고: daily 10개의 카테고리 분포가 vocab2/info_extraction3/core2/inference2/structure1로
-- 원래 규칙(카테고리당 2개)과 다르게 생성됐으나, 원본 내용을 그대로 유지했다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '기사에 등장한 ''턴키(Turn-key) 솔루션''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["설계부터 생산, 패키징 등 전 과정을 일괄 처리하여 완성품 형태로 공급하는 방식", "특정 제조 공정만 위탁받아 일부분만 대행하는 방식", "제품 생산 가격을 인하하기 위해 원자재 수급을 단일화하는 방식", "소비자가 직접 부품을 조립할 수 있도록 키트 형태로 제공하는 방식"]'::json,
    '설계부터 생산, 패키징 등 전 과정을 일괄 처리하여 완성품 형태로 공급하는 방식',
    '''턴키''는 키를 돌리면 제품이나 시스템이 즉시 작동할 수 있는 상태로 모든 과정을 일괄 제공하는 방식을 의미합니다.',
    '2문단의 메모리 단품 공급을 넘어 HBM, 파운드리, 패키징을 아우른다는 설명을 참고하세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    4
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '기사의 "선단 공정의 양산 경쟁력이 본격적으로 회복되고 있다"에서 ''양산(量産)''의 사전적 의미와 가장 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["대량 생산", "시범 제작", "소량 주문", "기술 연구"]'::json,
    '대량 생산',
    '''양산''은 제품을 대량으로 생산하는 것을 의미합니다.',
    '공장에서 대규모로 물건을 찍어내는 것을 뜻합니다.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    4
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    'KB증권에 따르면 2026년 4분기 삼성전자의 HBM 시장 점유율은 40% 수준에 근접할 것으로 전망됩니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '1문단과 3문단에 따르면 4분기 삼성전자의 HBM 시장 점유율이 40% 수준에 근접할 것으로 전망되었습니다.',
    '1문단 및 3문단의 4분기 점유율 숫자를 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    4
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '기사 본문에 제시된 삼성전자 파운드리 공정의 수율 현황으로 옳은 것은 무엇인가요?',
    'multiple_choice',
    '["4나노 수율 80% 이상, 2나노 수율 70% 이상", "4나노 수율 50% 미만, 2나노 수율 80% 이상", "4나노 수율 70% 이상, 2나노 수율 50% 미만", "4나노 수율 90% 이상, 2나노 수율 30% 이하"]'::json,
    '4나노 수율 80% 이상, 2나노 수율 70% 이상',
    '6문단에서 4나노 생산 수율은 80% 이상으로 안정화되었고 2나노 GAA 수율도 70% 이상으로 빠르게 개선되고 있다고 언급되었습니다.',
    '6문단의 수율 수치를 각각 확인하세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    4
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    'KB증권은 파운드리 사업이 몇 나노 언어처리장치(LPU) 양산 본격화에 힘입어 3분기부터 흑자 전환 가능성이 높아질 것으로 전망했나요? (숫자와 단어로 작성, 예: 4나노)',
    'short_answer',
    '[]'::json,
    '4나노',
    '7문단에서 "4나노 언어처리장치(LPU) 양산 본격화와 수율 안정화에 힘입어 흑자 전환 가능성이 한층 높아질 것"이라고 명시하고 있습니다.',
    '7문단에서 LPU 앞에 붙은 공정 수치를 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    4
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '이 기사의 중심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["삼성전자의 HBM 점유율 확대와 파운드리 경쟁력 회복에 따른 성장 전망", "글로벌 파운드리 업체 간 가격 경쟁 심화 및 수익성 악화 분석", "TSMC와 삼성전자의 2나노 공정 수율 주도권 다툼과 주가 전망", "원스톱 솔루션 공급 방식이 반도체 생태계에 미치는 부작용"]'::json,
    '삼성전자의 HBM 점유율 확대와 파운드리 경쟁력 회복에 따른 성장 전망',
    '기사는 삼성전자가 HBM 매출 비중 확대, 턴키 솔루션 제공 역량, 파운드리 수율 개선 등에 힘입어 향후 크게 성장할 것이라는 증권가 분석을 다루고 있습니다.',
    '기사 전체에서 삼성전자의 어떤 사업 분야들의 경쟁력 회복과 성장을 다루고 있는지 종합해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    4
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '이 기사에서 KB증권이 삼성전자의 HBM 사업 성장 가능성을 높게 평가한 핵심 이유가 아닌 것은 무엇인가요?',
    'multiple_choice',
    '["소비자용 스마트폰 시장의 유례없는 판매 호조", "HBM4 매출 급증 및 차세대 zHBM 로드맵 확보", "턴키(원스톱) 솔루션 공급 능력 보유", "TSMC와의 전략적 제휴를 통한 공급 선택지 제공"]'::json,
    '소비자용 스마트폰 시장의 유례없는 판매 호조',
    '기사에서는 HBM4 비중 확대, zHBM 로드맵, 턴키 공급 능력, TSMC 제휴 등을 성장 근거로 꼽았으며 스마트폰 판매 호조는 언급되지 않았습니다.',
    '4문단과 5문단에 제시된 HBM 사업의 전략적 성장 요인들을 확인해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    4
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '삼성전자의 2나노 파운드리 수율 개선은 파운드리 자체의 실적 개선뿐만 아니라 HBM 제품(베이스다이)의 경쟁력 향상에도 긍정적 영향을 미칠 것임을 추론할 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '6문단에서 "2나노 수율 개선은 향후 삼성 파운드리 실적뿐 아니라 HBM 베이스다이 경쟁력까지 동시에 끌어올릴 수 있어"라고 설명하고 있습니다.',
    '6문단 마지막 문장을 참고하여 2나노 수율과 HBM 경쟁력의 연관성을 파악해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    4
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"고객 맞춤형 커스텀 HBM 시장이 확대되고 가격 인상이 가능해짐에 따라, 향후 HBM 시장의 주도권은 구매자인 고객사보다 (                      ) 중심으로 재편될 것으로 예상된다."',
    'multiple_choice',
    '["판매자인 메모리 업체", "정부 규제 기관", "소비자 단체", "외부 패키징 하청업체"]'::json,
    '판매자인 메모리 업체',
    '9문단에 "HBM 공급 주도권은 판매자인 메모리 업체 중심의 재편이 예상된다"고 제시되어 있습니다.',
    '9문단에서 커스텀 HBM 가격 인상 후 시장 주도권이 어디로 넘어가는지 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    4
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '이 기사의 전체적인 논지 전개 구조로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["HBM 시장 점유율 전망 및 목표주가 제시 -> HBM 제품 로드맵과 원스톱 솔루션 강점 -> 파운드리 수율 개선 및 흑자 전망 -> 커스텀 HBM 시장 주도권 및 결론", "파운드리 수율 문제점 지적 -> HBM4 기술 결함 분석 -> 주가 하락 위험성 경고 -> 종합 결론", "원스톱 솔루션의 개념 설명 -> TSMC와의 경쟁 구도 비교 -> 파운드리 수율 개선 실패 요인 분석 -> 향후 과제", "커스텀 HBM 가격 하락 전망 -> 파운드리 사업부 매각 가능성 -> 메모리 반도체 시장 축소 우려 -> 결론"]'::json,
    'HBM 시장 점유율 전망 및 목표주가 제시 -> HBM 제품 로드맵과 원스톱 솔루션 강점 -> 파운드리 수율 개선 및 흑자 전망 -> 커스텀 HBM 시장 주도권 및 결론',
    '기사는 HBM 점유율 성장과 목표주가 제시로 시작하여, HBM 로드맵 및 턴키 솔루션, 파운드리 수율 개선, 커스텀 HBM 주도권 확보 순으로 호재를 나열하며 결론을 짓습니다.',
    '기사의 각 문단 첫 머리 흐름(HBM 점유율 -> zHBM 및 원스톱 -> 파운드리 2/4나노 수율 -> 커스텀 HBM)을 파악해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    4
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] 삼성전자는 베이스다이부터 인터레이어, 패키징, HBM까지 자체적으로 공급할 수 있는 데다 TSMC와의 전략적 제휴를 통한 공급도 가능해 고객사 선택지를 넓힐 수 있다는 분석이다.

[문제] 위 문단에서 ''패키징(Packaging)''이 의미하는 반도체 공정 단계로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["제조된 반도체 칩을 보호하고 기판과 전기적으로 연결하는 후공정 단계", "반도체 회로를 그리기 위해 실리콘 웨이퍼의 표면을 깎아내는 식각 단계", "웨이퍼 위에 미세한 회로 패턴을 빛으로 그리는 노광 단계", "반도체 원자재인 실리콘 잉곳을 얇게 잘라 웨이퍼를 만드는 전공정 단계"]'::json,
    '제조된 반도체 칩을 보호하고 기판과 전기적으로 연결하는 후공정 단계',
    '반도체 패키징은 칩을 외부 환경으로부터 보호하고 전력을 공급하며 입출력 신호를 연결하는 후공정을 말합니다.',
    '베이스다이, 인터레이어 등과 함께 가공된 칩을 완성품으로 엮는 단계를 생각해 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    4
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] 김 본부장은 "삼성 파운드리는 4나노 생산 수율이 80% 이상으로 안정화된 가운데... 선단 공정의 양산 경쟁력이 본격적으로 회복되고 있다"고 분석했다.

[문제] 위 문단의 ''수율(Yield)''은 ''생산된 전체 제품 중 결함 없이 합격한 정상 제품의 비율''을 의미합니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '반도체 제조에서 수율은 투입된 투입량 대비 결함이 없는 합격품의 비율을 나타냅니다.',
    '반도체 생산 시 수율이 높다는 것은 정상 제품이 많이 생산된다는 뜻임을 기억하세요.',
    'room',
    'vocab',
    'vocab_appropriateness',
    4
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] 차세대 HBM인 zHBM까지 구체적인 로드맵을 확보했다. 특히 발열 문제가 개선되고 대역폭이 획기적으로 개선된 zHBM은 고객사 입장에서 삼성전자의 원스톱 솔루션 공급 역량과 TSMC와 전략적 제휴를 통한 공급 등 다양한 선택지를 제공할 수 있다.

[문제] zHBM은 기존 제품 대비 발열 문제가 심화되었으나 대역폭이 넓어진 제품으로 평가받고 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '문단에서 zHBM은 "발열 문제가 개선되고 대역폭이 획기적으로 개선된" 제품이라고 기술되어 있습니다.',
    'zHBM의 발열 문제에 대해 문단에서 어떻게 평가했는지 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    4
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] 삼성전자의 2나노 게이트올어라운드(GAA) 수율도 70% 이상으로 빠르게 개선되고 있다.

[문제] 2나노 수율은 연초 몇 % 미만에서 빠르게 개선되었나요? (숫자 및 기호 포함 작성, 예: 50%)',
    'short_answer',
    '[]'::json,
    '50%',
    '8문단에 "2나노 수율 역시 연초 50% 미만에서 빠르게 개선되고 있어"라고 기재되어 있습니다.',
    '8문단에서 2나노 수율의 연초 수치를 확인해 보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    4
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] 발열 문제가 개선되고 대역폭이 획기적으로 개선된 zHBM은 고객사 입장에서 삼성전자의 원스톱 솔루션 공급 역량(베이스다이, 인터레이어, 패키징, HBM)과 TSMC와 전략적 제휴를 통한 공급 등 다양한 선택지를 제공할 수 있다는 점에서, 삼성전자 HBM 사업의 전략적 성장 기회를 한층 더 확대시키는 요인으로 작용할 전망이다.

[문제] 위 문단이 강조하는 삼성전자 HBM 사업의 핵심 차별화 경쟁력은 무엇인가요?',
    'multiple_choice',
    '["원스톱 솔루션 공급 능력 및 TSMC 제휴를 통한 고객 맞춤형 선택지 제공", "업계 최저 가격 정책을 통한 가격 파괴 전략", "메모리 패키징 외주 위탁을 통한 단가 절감", "단일 고객사에만 전량 독점 공급하는 공급 구조"]'::json,
    '원스톱 솔루션 공급 능력 및 TSMC 제휴를 통한 고객 맞춤형 선택지 제공',
    '문단은 베이스다이부터 패키징까지 아우르는 원스톱 솔루션 및 TSMC 제휴를 통한 다변화된 선택지 제공을 전략적 성장 요인으로 지적하고 있습니다.',
    '문단에 제시된 원스톱 솔루션 역량과 TSMC 제휴의 의미를 파악해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    4
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] 현재 삼성전자의 4나노 수율은 사실상 TSMC와 경쟁 가능한 수준에 근접한 것으로 판단되고, 2나노 수율 역시 연초 50% 미만에서 빠르게 개선되고 있어 미국 대형 고객사 확보도 연내 가시화될 가능성이 높다고 내다봤다.

[문제] 위 문단의 내용과 가장 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["파운드리 수율 급개선… 미국 대형 고객사 수주 가시화", "TSMC의 시장 독점으로 인한 삼성 파운드리의 입지 축소", "2나노 공정 개발 포기와 4나노 집중 전략", "미국 시장 철수와 아시아 고객사 중심 개편"]'::json,
    '파운드리 수율 급개선… 미국 대형 고객사 수주 가시화',
    '4나노 및 2나노 수율 개선으로 TSMC 수준에 근접하였으며 미국 대형 고객사 확보가 기대된다는 내용이 핵심입니다.',
    '4나노/2나노 수율 개선과 미국 고객사 확보 가능성에 초점을 맞추세요.',
    'room',
    'core_understanding',
    'core_title',
    4
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] 삼성전자는 1c 코어다이와 2나노미터 베이스다이를 적용한 HBM5 아키텍처도 확보했으며 차세대 제품인 zHBM까지 구체적인 제품 ____을/를 갖추고 있다.

[문제] 문맥상 빈칸에 들어갈 4글자 외래어 단어(기술 발전 계획)는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '로드맵',
    '4문단에 "차세대 제품인 zHBM까지 구체적인 제품 로드맵을 갖추고 있다는 설명이다"라고 등장합니다.',
    '4문단 마지막 부분에서 향후 제품 개발 계획을 뜻하는 외래어를 찾아보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    4
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] 고객 맞춤형 스펙에 기반한 커스텀 HBM은 큰 폭의 가격 인상이 유력한 HBM4 이후 추가적인 가격 인상이 가능하다고 봤다. 이에 따라 향후 HBM 공급 주도권은 판매자인 메모리 업체 중심의 재편이 예상된다.

[문제] 위 문단을 통해 추론할 수 있는 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["HBM 제조사의 가격 협상력이 강화되어 수익성이 크게 개선될 수 있다.", "구매자인 고객사가 제품 가격을 마음대로 결정하게 될 것이다.", "커스텀 HBM의 등장으로 메모리 단가가 급격히 하락할 것이다.", "메모리 반도체 시장이 범용 제품 중심의 단순 생산 구조로 돌아갈 것이다."]'::json,
    'HBM 제조사의 가격 협상력이 강화되어 수익성이 크게 개선될 수 있다.',
    '판매자인 메모리 업체 중심으로 주도권이 재편되고 추가 가격 인상이 가능해진다는 것은 메모리 제조사의 가격 협상력이 높아진다는 의미입니다.',
    '공급 주도권이 판매자(메모리 업체) 중심으로 바뀔 때 가격 결정권이 어떻게 될지 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    4
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] (A) 2나노 수율 개선은 파운드리 실적과 HBM 베이스다이 경쟁력을 동시에 끌어올릴 수 있다.
(B) 파운드리 사업은 올해 3분기부터 LPU 양산 본격화와 수율 안정화에 힘입어 흑자 전환 가능성이 높아질 것이다.
(C) 삼성 파운드리는 4나노 수율 80% 이상, 2나노 수율 70% 이상으로 선단 공정 양산 경쟁력을 회복하고 있다.

[문제] 위 문장들을 논리적 흐름에 맞게 배치한 순서는 무엇인가요?',
    'multiple_choice',
    '["(C) - (A) - (B)", "(A) - (C) - (B)", "(B) - (A) - (C)", "(C) - (B) - (A)"]'::json,
    '(C) - (A) - (B)',
    '수율 안정화 및 회복 현황(C)을 밝힌 뒤, 이 수율 개선이 가져올 시너지 효과(A)를 설명하고, 이에 따른 파운드리 흑자 전환 전망(B)으로 연결하는 것이 가장 자연스럽습니다.',
    '6문단과 7문단의 문장 배치 순서를 참고하세요.',
    'room',
    'structure',
    'structure_order',
    4
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '"60만전자 성장의 판이 커진다"…''잭팟'' 시나리오 근거는'),
    '[문단] 삼성전자는 베이스다이부터 패키징까지 자체 공급이 가능하다. [ ㄱ ] TSMC와의 전략적 제휴를 통한 공급도 가능하여 고객사에게 다양한 선택지를 제공한다.

[문제] [ ㄱ ] 위치에 들어갈 가장 적절한 접속어는 무엇인가요?',
    'multiple_choice',
    '["아울러", "그러나", "반면에", "따라서"]'::json,
    '아울러',
    '자체 공급 능력이라는 장점에 더해 TSMC와의 제휴라는 또 다른 장점을 첨가하여 설명하고 있으므로 순접/나열의 접속어가 적절합니다.',
    '앞 문장의 자체 공급 역량과 뒤 문장의 TSMC 제휴 가능성이 대립되는 내용인지, 추가되는 내용인지 파악해 보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    4
);

-- 기사(''HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '기사에 등장한 ''SMR(소형모듈원자로)''의 주요 특징으로 가장 적절한 설명은 무엇인가요?',
    'multiple_choice',
    '["대형 원전보다 출력을 낮추고 설비를 모듈화한 차세대 원전", "바다 위에서만 작동하도록 특수 설계된 수중 발전 장치", "화석 연료를 사용하여 빠른 시간 내에 전기를 만드는 화력 발전기", "태양광과 풍력을 합쳐서 만든 휴대용 에너지 저장장치"]'::json,
    '대형 원전보다 출력을 낮추고 설비를 모듈화한 차세대 원전',
    '6문단에 "SMR은 대형 원전보다 출력을 낮추고 설비를 모듈화한 차세대 원전이다"라고 명시되어 있습니다.',
    '6문단 마지막 문장에서 SMR이 어떤 원전인지 정의한 부분을 읽어보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    3
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '기사의 "AI 인프라 시장을 선점해 나갈 것"에서 ''선점(先占)해''의 의미와 가장 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["남보다 앞서 차지해", "나중에 천천히 맡아", "서로 공정하게 나누어", "타인에게 넘겨주어"]'::json,
    '남보다 앞서 차지해',
    '''선점하다''는 어떤 자리를 남보다 먼저 차지한다는 뜻입니다.',
    '8문단에서 경쟁자보다 한발 앞서 시장 위치를 확보한다는 의미를 생각해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    3
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    'HD현대중공업이 울산 울주군 온산읍에 만드는 힘센엔진 신규 생산기지의 규모는 3GW입니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '3문단에서 "8336억 원을 투입해 울산 울주군 온산읍에 3GW 규모의 ''힘센엔진'' 신규 생산기지를 만든다"라고 밝혔습니다.',
    '3문단 첫 번째 문장에서 힘센엔진 생산기지의 GW 수치를 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    3
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    'HD현대중공업이 SMR 주기기 전용 공장을 건립하기 위해 투입하는 사업비와 완공 목표 시기로 옳은 것은 무엇인가요?',
    'multiple_choice',
    '["2386억 원 / 2029년 상반기", "8336억 원 / 2028년 하반기", "1조 722억 원 / 2030년 상반기", "6271억 원 / 2027년 하반기"]'::json,
    '2386억 원 / 2029년 상반기',
    '6문단에 "2386억 원이 투입되며, 2029년 상반기 완공을 목표로 하고 있다"라고 명시되어 있습니다.',
    '6문단에서 SMR 전용 공장에 투자되는 금액과 목표 완공 시점을 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    3
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    'HD현대중공업이 2030년까지 확대하기로 한 힘센엔진의 전체 생산능력은 몇 GW인가요? (숫자 및 단위 포함 작성, 예: 7.2GW)',
    'short_answer',
    '[]'::json,
    '7.2GW',
    '4문단 마지막 문장에 "회사는 힘센엔진의 전체 생산능력을 2030년까지 7.2GW로 확대한다는 방침이다"라고 나와 있습니다.',
    '4문단 마지막 문장에서 2030년 목표 생산능력 수치를 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    3
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '이 기사의 중심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["HD현대중공업의 AI 데이터센터 전력 수요 대응을 위한 발전엔진 및 SMR 1조 원 대 투자", "미국 테라파워사의 원자로 용기 독점 수주 및 기술 합작 발표", "글로벌 데이터센터의 전력 소비량 급증으로 인한 전력 요금 인상 전망", "전남 영암 HD현대엔진 공장의 선박용 엔진 전용 생산 체계 전환"]'::json,
    'HD현대중공업의 AI 데이터센터 전력 수요 대응을 위한 발전엔진 및 SMR 1조 원 대 투자',
    '기사는 HD현대중공업이 AI 시대 급증하는 전력 수요에 맞춰 발전엔진과 SMR 분야에 1조 원 이상을 투자한다는 내용을 중심으로 다루고 있습니다.',
    '기사의 제목과 1~2문단에서 투자의 주체, 규모, 대상 분야를 종합해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    3
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '이 기사에서 HD현대중공업이 육상용 발전엔진 및 SMR 생산 설비를 확충하기로 결정한 주요 배경은 무엇인가요?',
    'multiple_choice',
    '["AI 데이터센터 확산에 따른 전력 수요의 급증", "기존 선박용 엔진 시장의 수요 전면 중단", "대형 원자력 발전소 건립 전면 금지 규제", "국내 조선 산업의 수주량 급감에 따른 업종 전환"]'::json,
    'AI 데이터센터 확산에 따른 전력 수요의 급증',
    '1문단과 5문단에 따르면 AI 데이터센터발 전력 수요가 폭증함에 따라 새로운 전력 공급원 시장을 선점하기 위해 대규모 투자를 단행했습니다.',
    '1문단 첫 문장과 5문단에서 투자가 마련된 원인을 찾아보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    3
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '새로운 생산기지가 가동되면 조선소 본공장은 선박용 엔진에, 신규 공장과 영암 공장은 육상용 엔진에 집중하는 생산 이원화 효과가 발생할 것임을 추론할 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '4문단에서 선박용은 울산 본공장이, 육상용은 신규 공장과 전남 영암 공장이 맡는 이원화 체계를 갖추게 된다고 설명합니다.',
    '4문단 두 번째 문장에 명시된 선박용과 육상용 엔진의 생산 기지 분담 역할을 참고하세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    3
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"가트너의 조사에 따르면 세계 데이터센터 전력 소비량은 지속적으로 증가할 전망이다. 이에 따라 발전엔진과 SMR 같은 (                      ) 장비를 생산하는 기업들의 시장 기회가 커질 것이다."',
    'multiple_choice',
    '["전력 공급", "소비자 가전", "원유 정제", "친환경 농업"]'::json,
    '전력 공급',
    '데이터센터 소비 전력이 급증하므로 전기를 만들어 내는 전력 공급 인프라 장비 수요가 증가하게 됩니다.',
    '데이터센터 가동에 꼭 필요한 자원이 무엇인지 떠올려 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    3
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '기사의 본문 전개 순서로 가장 바르게 연결된 것은 무엇인가요?',
    'multiple_choice',
    '["투자 결정 및 총액 발표 -> 발전엔진 신공장 세부계획 -> SMR 전용공장 구축 및 테라파워 협력 -> 미국 계약 성과", "발전엔진 신공장 세부계획 -> 미국 계약 성과 -> 투자 결정 및 총액 발표 -> SMR 전용공장 구축 및 테라파워 협력", "미국 계약 성과 -> SMR 전용공장 구축 및 테라파워 협력 -> 발전엔진 신공장 세부계획 -> 투자 결정 및 총액 발표", "SMR 전용공장 구축 및 테라파워 협력 -> 투자 결정 및 총액 발표 -> 미국 계약 성과 -> 발전엔진 신공장 세부계획"]'::json,
    '투자 결정 및 총액 발표 -> 발전엔진 신공장 세부계획 -> SMR 전용공장 구축 및 테라파워 협력 -> 미국 계약 성과',
    '기사는 투자 발표(1~2문단) 후 발전엔진 공장 계획(3~5문단), SMR 공장 및 테라파워 협력(6~7문단), 미국 수주 성과(9문단) 순으로 작성되었습니다.',
    '글의 도입부부터 마지막 한편 문단까지 주제가 어떻게 확장되는지 순서를 읽어보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    3
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] 더불어 선박용 엔진은 기존 울산 본공장이, 육상용은 신규 공장과 전남 영암 HD현대엔진이 맡는 이원화 체계도 갖추게 된다.

[문제] 위 문단에서 ''이원화(二元化)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["체계나 기능을 두 개의 역할이나 단위로 나누어 다루는 것", "모든 생산 과정을 하나의 공장으로 완전히 통합하는 것", "기존 설비를 모두 폐기하고 새로운 기술로 전면 교체하는 것", "제품 생산을 해외 전문 하청 기업에 전량 맡기는 것"]'::json,
    '체계나 기능을 두 개의 역할이나 단위로 나누어 다루는 것',
    '''이원화''는 하나로 뭉쳐 있던 체계나 대상, 역할을 둘로 나누어 관리하거나 추진하는 것을 의미합니다.',
    '선박용과 육상용을 서로 다른 공장에 분담시켜 운영한다는 뜻을 떠올려 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    3
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] 급증하는 전력 수요에 선제적으로 대응하면서 글로벌 AI 인프라 시장을 선점해 나갈 것이다.

[문제] 위 문단의 ''선제적(先制的)''은 ''어떤 일이 일어나기 전에 미리 대책을 세워 행동하는'' 의미를 갖습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''선제적''이란 상대보다 앞서 행동하거나 문제 발생 전에 미리 대비하는 태도를 뜻합니다.',
    '전력 난이 심해지기 전에 미리 투자를 결정했다는 문맥을 떠올려 보세요.',
    'room',
    'vocab',
    'vocab_appropriateness',
    3
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] HD현대는 2022년 테라파워에 투자한 뒤 2024년 12월 원자로 용기를 수주했고, 올해 5월에는 나트륨 원자로 주기기 핵심설비 제작·공급 우선협상대상자로 선정되기도 했다.

[문제] HD현대중공업은 미국의 테라파워에 투자한 후 2024년 12월에 원자로 용기를 수주했습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '문단에 "2022년 테라파워에 투자한 뒤 2024년 12월 원자로 용기를 수주했고"라고 명확히 표기되어 있습니다.',
    '문단 중반부의 연도별 협력 경과(2022년 투자 -> 2024년 12월 수주)를 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    3
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] 글로벌 시장조사업체 가트너에 따르면 전 세계 데이터센터 전력 소비량은 지난해 447TWh였다.

[문제] 데이터센터 전력 소비량은 지난해 447TWh에서 올해 몇 TWh로 증가하나요? (숫자만 작성, 예: 565)',
    'short_answer',
    '[]'::json,
    '565',
    '5문단에서 "지난해 447TWh에서 올해 565TWh로 26.4% 늘었고"라고 기술되어 있습니다.',
    '5문단 두 번째 문장에 명시된 올해 데이터센터 전력 소비량 수치를 확인해 보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    3
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] 한편, HD현대중공업은 올해 4월과 8월 미국 에이페리온에너지그룹, 코반에너지그룹과 각각 6271억 원, 9560억 원 규모의 발전설비 공급 계약을 맺으며 미국 데이터센터 전력 인프라 시장에 진출한 바 있다.

[문제] 위 문단에서 서술하고 있는 핵심 내용은 무엇인가요?',
    'multiple_choice',
    '["HD현대중공업의 미국 데이터센터 전력 인프라 시장 진출 성과", "미국 에이페리온에너지그룹의 한국 시장 직접 진출 소식", "국내 데이터센터 전력 가격 인상에 따른 기업 수주 감소", "친환경 해상 풍력 발전기 제조 계약 체결 현황"]'::json,
    'HD현대중공업의 미국 데이터센터 전력 인프라 시장 진출 성과',
    '문단은 미국 에너지 기업들과의 대규모 발전설비 공급 계약을 통해 미국 데이터센터 전력 시장 진출 성과를 낸 사실을 전달합니다.',
    '계약 상대방과 금액, 그리고 문단 마지막 부분의 진출 성과를 결합하여 파악하세요.',
    'room',
    'core_understanding',
    'core_topic',
    3
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] 회사는 8336억 원을 투입해 울산 울주군 온산읍에 3GW 규모의 ''힘센엔진'' 신규 생산기지를 만든다. 21만 5000㎡(6만 5000평)의 부지에 엔진 조립·시운전, 크랭크샤프트 가공, 엔진 블록 주조 공장 등이 들어선다. 착공 시점은 내년 1분기며 2028년 준공 후 가동을 목표로 하고 있다.

[문제] 위 문단의 내용에 가장 잘 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["온산에 8336억 원 투입… 3GW 규모 힘센엔진 생산기지 구축", "울산 조선소 본공장의 선박용 엔진 생산 전면 중단", "전남 영암 공장 이전을 통한 비용 절감 전략", "해외 엔진 제조업체 인수를 통한 글로벌망 확대"]'::json,
    '온산에 8336억 원 투입… 3GW 규모 힘센엔진 생산기지 구축',
    '온산 부지에 8336억 원을 투입해 3GW 규모의 힘센엔진 신규 공장을 짓는 구체적인 투자 계획을 설명하고 있습니다.',
    '투입 예산과 건립 위치, 제품명 및 스펙을 모두 아우르는 제목을 선택하세요.',
    'room',
    'core_understanding',
    'core_title',
    3
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] HD현대중공업은 선박용 엔진으로 축적한 높은 기술력을 바탕으로, AI 시대 전력난으로 인해 급성장하는 ____ 발전 시장으로 사업 영역을 크게 확장하고 있다.

[문제] 문맥상 빈칸에 들어갈 두 글자 단어(바다가 아닌 땅)는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '육상',
    '본문 5문단 등에 "선박용 엔진 기술력을 육상 발전 시장으로 확장해"라고 명시되어 있습니다.',
    '선박용(해상)과 대비되는, 땅 위에서 쓰이는 발전 시장을 뜻하는 단어를 찾아보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    3
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] SMR 투자는 미국의 SMR 개발기업 테라파워의 오랜 협력이 밑거름이 됐다. 앞서 HD현대는 2022년 테라파워에 투자한 뒤 2024년 12월 원자로 용기를 수주했고, 올해 5월에는 나트륨 원자로 주기기 핵심설비 제작·공급 우선협상대상자로 선정되기도 했다.

[문제] 위 문단을 통해 추론할 수 있는 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["선제적인 기술 투자와 글로벌 기업과의 파트너십이 신사업 수주 경쟁력으로 이어졌다.", "테라파워사와의 협력 관계는 이번 SMR 공장 건립 직전에 종료되었다.", "HD현대중공업은 SMR의 원천 기술 설계 능력을 독점하여 테라파워를 지배하고 있다.", "원자로 용기 수주 실적 부족으로 인해 SMR 공장 설립이 지연되고 있다."]'::json,
    '선제적인 기술 투자와 글로벌 기업과의 파트너십이 신사업 수주 경쟁력으로 이어졌다.',
    '2022년 지분 투자를 시작으로 꾸준한 협력 관계를 맺어 우선협상대상자로 선정되고 SMR 전용 공장 투자로까지 연결되었음을 추론할 수 있습니다.',
    '테라파워와의 연도별 협력 과정이 사업에 어떤 긍정적 영향을 미쳤는지 생각해보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    3
),
-- 19. structure / structure_order (multiple_choice) — 원본은 선택지 2개였으나 규칙(4개)에 맞춰 문장 하나 추가해 재구성
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] (A) 데이터센터 전력 소비량은 지난해 447TWh에서 2030년 1200TWh를 넘어설 전망이다.
(B) 발전엔진 생산 기지 확대는 선박용 기술력을 육상 발전으로 확장해 전력난에 선제 대응하기 위함이다.
(C) HD현대중공업은 AI 데이터센터발 전력 수요 급증에 대응해 울산에 발전엔진과 SMR 생산 설비를 확충한다.

[문제] 세 문장을 논리적으로 자연스럽게 이어지도록 나열한 것은 무엇인가요?',
    'multiple_choice',
    '["(C) - (B) - (A)", "(A) - (B) - (C)", "(B) - (A) - (C)", "(C) - (A) - (B)"]'::json,
    '(C) - (B) - (A)',
    '투자 사실(C)을 먼저 알리고 그 목적(B)을 설명한 뒤, 이를 뒷받침하는 전력 소비 증가 데이터(A)를 제시하는 순서가 자연스럽습니다.',
    '사실 전달 -> 목적 설명 -> 근거 데이터 제시 흐름을 확인해 보세요.',
    'room',
    'structure',
    'structure_order',
    3
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = 'HD현대중공업, 울산에 ‘발전엔진·SMR’ 1조 투자'),
    '[문단] HD현대중공업은 울산 온산읍에 발전엔진 신규 기지를 구축한다. [ ㄱ ] 울산조선소 부지 내에는 2386억 원을 투입해 SMR 주기기 전용 공장을 건립한다.

[문제] [ ㄱ ] 위치에 들어갈 문맥상 가장 적절한 연결어는 무엇인가요?',
    'multiple_choice',
    '["이어", "그러나", "왜냐하면", "마침내"]'::json,
    '이어',
    '발전엔진 생산기지 구축 계획을 소개한 후, 두 번째 투자 축인 SMR 전용 공장 건립을 나열하여 연결하고 있으므로 ''이어''가 적절합니다.',
    '두 가지 대규모 투자 사업을 순차적으로 소개하는 나열 관계임을 확인하세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    3
);

-- 기사(''"생산·고용 늘리려면 세제지원 실효성 높여야"'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '기사에 등장한 ''실효성(實效性)''의 단어 뜻으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["실제로 효과를 거둘 수 있는 성질", "이론적으로만 존재하는 가상의 성질", "법적 처벌을 강제하는 강력한 권한", "비용을 최소한으로 줄이는 경제적 성질"]'::json,
    '실제로 효과를 거둘 수 있는 성질',
    '''실효성''이란 실제로 실질적인 효과를 나타낼 수 있는 성질이나 특성을 의미합니다.',
    '제목의 ''세제지원 실효성을 높여야''라는 표현에서 제도 정책이 실제로 효과를 거두어야 한다는 의미를 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    4
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '기사 중 "기업들이 세제혜택을 실제 활용해 생산·투자·고용을 늘릴 수 있도록"에서 ''활용해''와 가장 뜻이 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["이용해", "방치해", "축소해", "제한해"]'::json,
    '이용해',
    '''활용하다''는 쓸모 있게 잘 이용한다는 뜻이므로 ''이용해''가 가장 적절합니다.',
    '혜택을 효과적으로 써서 이점을 얻는다는 문맥을 고려해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    4
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '한국경제인협회가 제출한 의견서에는 10개 법령별 51개 과제가 담겨 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '4문단에 "의견서는 국내 주요 기업 의견을 수렴해 마련한 것으로, 10개 법령별 51개 과제를 담겼다"라고 명시되어 있습니다.',
    '4문단을 읽고 법령 수와 과제 수를 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    4
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '한경협이 국내생산세액공제의 적용 대상으로 추가 확대를 건의한 3가지 분야로 올바르게 짝지어진 것은 무엇인가요?',
    'multiple_choice',
    '["미래형자동차, 바이오의약품·백신, 소형모듈원자로(SMR)", "태양광, 풍력, 이차전지", "반도체, AI 로봇부품, 디스플레이", "조선, 철강, 석유화학"]'::json,
    '미래형자동차, 바이오의약품·백신, 소형모듈원자로(SMR)',
    '5문단에 지원 대상을 기존 6대 분야 외에 "미래형자동차, 바이오의약품·백신, 소형모듈원자로(SMR) 등으로 넓혀야 한다고 건의했다"라고 나와 있습니다.',
    '5문단을 확인하여 한경협이 추가 확대를 요구한 분야들을 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    4
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '한경협이 요구한 산업기술 연구개발용 수입 물품에 대한 관세 감면 비율은 몇 %인가요? (숫자만 작성)',
    'short_answer',
    '[]'::json,
    '80',
    '9문단에서 "산업기술 연구개발용 수입 물품에 대한 관세 감면(80%) 유지"라는 내용을 확인할 수 있습니다.',
    '9문단에서 관세 감면 괄호 안의 수치를 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    4
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '이 기사의 전체적인 핵심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["기업의 생산과 청년 고용 창출을 위한 세제개편안의 실효성 제고 및 보완 건의", "정부의 2026년 세제개편안 국회 통과에 따른 대기업 세금 대폭 감면 확정", "외국계 기업에 대한 국내 생산 세액공제 대폭 확대 발표", "지방 인구 감소 극복을 위한 대기업 본사 이전 정책 조율"]'::json,
    '기업의 생산과 청년 고용 창출을 위한 세제개편안의 실효성 제고 및 보완 건의',
    '기사는 한경협이 경제계 의견을 모아 생산·투자·고용을 활성화할 수 있도록 세제개편안의 지원 대상과 요건을 보완해달라고 국회에 제출한 의견서의 주요 내용을 다루고 있습니다.',
    '1문단과 마지막 문단을 참고해 경제계(한경협)가 세제개편안에 대해 요구하는 바가 무엇인지 정리해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    4
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '한경협이 대기업을 통합고용세액공제 대상에서 제외하려는 방안에 반대한 주요 이유는 무엇인가요?',
    'multiple_choice',
    '["청년 고용 유인이 줄어들 수 있기 때문", "지방 인구 유출이 가속화되기 때문", "외국 기업과의 기술 격차가 벌어지기 때문", "수입 관세 감면 혜택이 중단되기 때문"]'::json,
    '청년 고용 유인이 줄어들 수 있기 때문',
    '7문단에 "대기업을 통합고용세액공제 대상에서 제외하려는 방안에 대해서는 청년 고용 유인이 줄어들 수 있다며 대기업 적용을 유지해야 한다고 밝혔다"라고 설명되어 있습니다.',
    '7문단에서 대기업 대상 제외 시 우려되는 부작용을 찾아보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    4
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '현재 정부의 국내생산세액공제안은 국내 판매분뿐만 아니라 해외 수출분까지 공제 대상에 포함하고 있음을 알 수 있다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '6문단에 "판매 지역과 관계없이 지원하는 미국·일본과 달리 국내 판매분만 공제 대상으로 한 요건도 수출까지 포함하도록 개선하고"라고 되어 있으므로, 현재 정부안은 국내 판매분만 공제 대상으로 정하고 있습니다.',
    '6문단 첫 줄에서 현행 정부안의 공제 대상 요건 범위를 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    4
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"한경협은 세액공제 금액을 당해 연도에 다 사용하지 못하더라도 이를 손실 처리하지 않고 향후 최대 15년 이상 이월하여 차감받을 수 있도록 (                      )을 늘려줄 것을 건의했다."',
    'multiple_choice',
    '["세액공제 이월 기간", "통합 고용 의무 기간", "수입 관세 유예 기간", "국회 심사 유예 기간"]'::json,
    '세액공제 이월 기간',
    '9문단에서 "최대 10년인 세액공제 이월 기간을 15년 이상으로 늘려달라는 내용도 담겼다"라고 언급되어 있습니다.',
    '9문단 뒷부분에서 10년에서 15년 이상으로 연장을 건의한 항목을 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    4
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '기사의 내용을 바탕으로 한 세제개편안의 국회 제출 절차 순서로 올바른 것은 무엇인가요?',
    'multiple_choice',
    '["정부안 최종 확정(국무회의) -> 국회 제출 -> 정기국회 심사", "국회 제출 -> 국무회의 최종 확정 -> 정기국회 심사", "정기국회 심사 -> 국무회의 확정 -> 국회 제출", "경제계 의견 수렴 -> 정기국회 심사 -> 국무회의 최종 확정"]'::json,
    '정부안 최종 확정(국무회의) -> 국회 제출 -> 정기국회 심사',
    '3문단에 따르면 9월 1일 국무회의에서 최종 확정된 후 이달 3일까지 국회에 제출되어 정기국회에서 심사될 예정입니다.',
    '3문단에 나오는 세제개편안의 날짜별 절차 순서를 읽어보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    4
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] 미사용 공제액을 현금으로 돌려주는 환급제를 도입할 것도 요청했다.

[문제] 위 문단에서 ''환급(還給)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["메우거나 도로 돌려줌", "타인에게 임의로 양도함", "지불을 일정 기간 유예함", "새로운 조건으로 재계약함"]'::json,
    '메우거나 도로 돌려줌',
    '''환급''이란 이미 납부했거나 징수한 금액 또는 쓸 수 없었던 공제액 등을 도로 돌려주는 것을 의미합니다.',
    '미사용 공제액을 현금으로 돌려준다는 뒤의 표현을 참고하세요.',
    'room',
    'vocab',
    'vocab_meaning',
    4
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] 산업위기지역과 인구감소지역에는 세액공제율에 곱해지는 지방우대계수 중 가장 높은 1.5를 적용해 지역 세제혜택을 강화해야 한다고 제안했다.

[문제] 위 문단의 ''강화(強化)해야''는 ''수준이나 정도를 높이거나 더 튼튼하게 만들어야''한다는 뜻으로 올바르게 쓰였습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''강화하다''는 세제혜택의 폭과 지원 수준을 기존보다 높인다는 의미로 적절하게 사용되었습니다.',
    '혜택을 축소하는 것이 아니라 더 높여 지원한다는 문맥을 확인하세요.',
    'room',
    'vocab',
    'vocab_appropriateness',
    4
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] 이어 판매 지역과 관계없이 지원하는 미국·일본과 달리 국내 판매분만 공제 대상으로 한 요건도 수출까지 포함하도록 개선하고, 미사용 공제액을 현금으로 돌려주는 환급제를 도입할 것도 요청했다.

[문제] 미국과 일본은 판매 지역과 관계없이 세액공제를 지원하고 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '문단 첫머리에 "판매 지역과 관계없이 지원하는 미국·일본과 달리"라고 명시되어 있으므로 사실입니다.',
    '문단 첫 문장의 미국·일본 관련 설명을 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    4
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] 한경협은 산업위기지역과 인구감소지역에 세액공제율을 높이기 위해 지방우대계수 중 가장 높은 수치를 적용해 달라고 제안했다.

[문제] 그 수치는 얼마인가요? (소수점 포함 숫자로 작성, 예: 1.5)',
    'short_answer',
    '[]'::json,
    '1.5',
    '8문단에서 "지방우대계수 중 가장 높은 1.5를 적용해"라고 기술되어 있습니다.',
    '8문단에서 건의된 가장 높은 지방우대계수 숫자를 확인해 보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    4
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] 먼저 한경협은 정부가 신설하기로 한 국내생산세액공제와 관련해서는 지원 대상을 태양광·풍력·이차전지·반도체·핵심소재·AI 로봇부품 등 6대 분야 외에 미래형자동차, 바이오의약품·백신, 소형모듈원자로(SMR) 등으로 넓혀야 한다고 건의했다.

[문제] 위 문단의 핵심 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["국내생산세액공제 지원 대상 분야의 확대 건의", "6대 첨단 미래 산업의 대규모 해외 이전 계획", "정부의 국내생산세액공제제도 전면 폐지 결정", "친환경 에너지 분야에 대한 정부 지원 중단 요청"]'::json,
    '국내생산세액공제 지원 대상 분야의 확대 건의',
    '문단은 기존 6대 분야에 더해 미래형자동차, 바이오의약품, SMR 등으로 공제 대상 범위를 넓혀달라는 한경협의 건의 내용을 다루고 있습니다.',
    '문단 전체가 어떤 제도의 ''지원 대상 범위 확대''를 요구하는지 파악해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    4
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] 한경협은 대기업을 통합고용세액공제 대상에서 제외하려는 방안에 대해서는 청년 고용 유인이 줄어들 수 있다며 대기업 적용을 유지해야 한다고 밝혔다.

[문제] 위 문단의 내용에 가장 잘 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["청년 고용 위축 우려… 대기업 통합고용세액공제 유지 촉구", "대기업 고용세액공제 폐지 및 청년 지원금 증액", "중소기업 전용 고용 세제혜택 대폭 축소 개편", "청년 취업자 대상 직접 소득세 면제 제도 도입"]'::json,
    '청년 고용 위축 우려… 대기업 통합고용세액공제 유지 촉구',
    '문단은 대기업을 고용세액공제 대상에서 제외할 경우 청년 고용이 줄어들 수 있으므로 대기업 대상 적용을 유지해야 한다는 주장을 담고 있습니다.',
    '대기업 통합고용세액공제를 제외하는 방안에 대한 한경협의 반대 이유와 요령을 포함한 제목을 고르세요.',
    'room',
    'core_understanding',
    'core_title',
    4
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] 세액공제 금액이 발생해도 당해 연도 이익이 적어 공제받지 못하는 기업을 위해, 미사용 공제액을 즉시 현금으로 환급하거나 공제권을 연장해 주는 조치가 없다면 세제지원의 ____이 크게 떨어진다.

[문제] 기사의 핵심 주제어에 해당하며, 빈칸에 들어갈 세 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '실효성',
    '기사의 1문단 및 제목에서 언급된 ''실효성''이 빈칸에 가장 적절합니다.',
    '제목과 1문단에 사용된 정책의 실제 효과성을 뜻하는 단어를 떠올려 보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    4
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] 산업위기지역과 인구감소지역에는 세액공제율에 곱해지는 지방우대계수 중 가장 높은 1.5를 적용해 지역 세제혜택을 강화해야 한다고 제안했다.

[문제] 위 제안을 한 바탕이 되는 추론으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["지방에 대한 세제 우대를 강화하면 기업의 지방 투자를 유인하여 지역 경제 활성화에 기여할 수 있다.", "지방우대계수를 높이면 지방 기업들의 수도권 이전이 더욱 촉진된다.", "산업위기지역에는 세금 감면보다 직접적인 정부 보조금 지급만이 유일한 해결책이다.", "지방의 세액공제율을 높이면 국가 전체의 관세 수입이 대폭 늘어난다."]'::json,
    '지방에 대한 세제 우대를 강화하면 기업의 지방 투자를 유인하여 지역 경제 활성화에 기여할 수 있다.',
    '지방우대계수 최고 수준 적용 요구는 낙후되거나 위기를 겪는 지방 지역에 세금 감면 혜택을 크게 주어 기업의 지방 투자 및 상생을 유도하기 위함입니다.',
    '세제혜택 강화가 지방 경제나 기업 투자 유치에 어떤 도움이 될지 추론해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    4
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] (A) 기업들이 세제혜택을 실제 활용해 생산·투자·고용을 늘릴 수 있도록, 정기 국회 논의 과정에서 지원 대상과 요건 등을 합리적으로 개선·보완할 필요가 있다.
(B) 한국경제인협회는 정부의 ''2026년 세제개편안''에 대한 개선·보완 의견서를 최근 국회에 제출했다.

[문제] 기사의 도입부(B)와 결론부(A)의 논리적 연결 관계로 올바른 것은 무엇인가요?',
    'multiple_choice',
    '["(B)에서 세제개편안 의견서 제출 사실을 밝히고, (A)에서 경제본부장의 멘트를 통해 의견서 제출의 목적과 당부를 마무리로 제시한다.", "(A)에서 구체적 문제점을 제기하고, (B)에서 정부의 법안 최종 통과 소식을 전달한다.", "(B)에서 국회의 세법 심사 완료 결과를 보고하고, (A)에서 세법 개정안의 시행령을 발표한다.", "(A)와 (B)는 아무런 논리적 연관성이 없는 독립된 통계 수치 발표이다."]'::json,
    '(B)에서 세제개편안 의견서 제출 사실을 밝히고, (A)에서 경제본부장의 멘트를 통해 의견서 제출의 목적과 당부를 마무리로 제시한다.',
    '기사 초반에 한경협의 의견서 제출 사실을 알리고, 마지막에 본부장의 말을 빌려 국회 심사 과정에서의 합리적 보완 필요성을 강조하며 마무리하는 구조입니다.',
    '의견서 제출이라는 행동(B)과 이를 총평하는 인터뷰 당부(A)의 역할을 파악하세요.',
    'room',
    'structure',
    'structure_order',
    4
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“생산·고용 늘리려면 세제지원 실효성 높여야”'),
    '[문단] 한경협은 세액공제 대상을 해외 수출분까지 확장해야 한다고 지적했다. [ ㄱ ] 미사용 공제액을 현금으로 환급해 주는 제도 도입도 함께 건의했다.

[문제] [ ㄱ ] 위치에 들어가기에 가장 자연스러운 연결어는 무엇인가요?',
    'multiple_choice',
    '["아울러", "반면에", "결국", "그에 반해"]'::json,
    '아울러',
    '수출분 공제 대상 포함 요구에 이어, 미사용 공제액 현금 환급제라는 추가적인 건의 사항을 덧붙이고 있으므로 첨가의 연결어인 ''아울러''가 적절합니다.',
    '앞 문장과 뒤 문장이 대립되는지, 아니면 추가적인 건의 사항인지 파악해 보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    4
);

-- 기사(''갤폴드보다 101만원 비싸다…"원 모어 띵" 애플 폴더블 통할까'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '기사에 나오는 단어 ''후발(後發)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["다른 사람이나 단체보다 뒤늦게 일어나거나 출발함", "가장 먼저 앞장서서 기술을 개발함", "제품의 가격을 대폭 낮추어 판매함", "해외 시장으로 제품을 수출함"]'::json,
    '다른 사람이나 단체보다 뒤늦게 일어나거나 출발함',
    '''후발''은 남보다 뒤늦게 출발하거나 나중에 행동에 나서는 것을 뜻합니다.',
    '삼성이 2019년에 낸 폴더블폰을 애플이 7년 뒤에야 냈다는 문맥을 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    2
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '기사의 "애플의 뒤늦은 시장 진입을 꼬집었다"에서 ''꼬집었다''와 가장 뜻이 비슷한 단어는 무엇인가요?',
    'multiple_choice',
    '["비판했다", "칭찬했다", "축하했다", "방관했다"]'::json,
    '비판했다',
    '''꼬집다''는 상대방의 약점이나 잘잘못을 아프게 지적하거나 비판하는 것을 의미합니다.',
    '삼성전자가 엑스(X)에 풍자적인 글을 올려 애플을 지적한 성격을 생각해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    2
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '아이폰 듀오의 방진·방수 등급은 IP68로, 갤럭시Z 폴드8(IP48)보다 먼지 차단 성능이 높습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '6문단에 "방진·방수 등급은 IP68로 갤럭시Z 폴드8의 IP48보다 먼지 차단 성능이 높다"라고 나와 있습니다.',
    '6문단에서 두 제품의 방진·방수 등급 비교 수치를 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    2
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '기사 본문에 명시된 아이폰 듀오의 화면 스펙으로 옳은 것은 무엇인가요?',
    'multiple_choice',
    '["접었을 때 5.4인치, 펼치면 7.6인치", "접었을 때 6.1인치, 펼치면 8.0인치", "접었을 때 4.8인치, 펼치면 6.7인치", "접었을 때 5.0인치, 펼치면 9.2인치"]'::json,
    '접었을 때 5.4인치, 펼치면 7.6인치',
    '4문단에 "접었을 때 화면은 5.4인치, 펼치면 ''아이폰18 프로맥스''보다 50% 넓은 7.6인치다"라고 명시되어 있습니다.',
    '4문단 첫 번째 문장의 화면 인치 수치를 확인하세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    2
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '국내 출시 기준, 아이폰 듀오 256GB 모델의 최저 출고가는 얼마인가요? (원 단위 포함 작성, 예: 329만원)',
    'short_answer',
    '[]'::json,
    '329만원',
    '7문단에서 "국내 출고가는 아이폰 듀오가 256기가바이트(GB) 329만원부터"라고 표기되어 있습니다.',
    '7문단 두 번째 문장에서 아이폰 듀오의 최저 출고가를 확인하세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    2
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '이 기사의 전체적인 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["애플의 첫 폴더블폰 ''아이폰 듀오'' 공개 및 주요 스펙과 가격, 시장 영향", "삼성전자 갤럭시Z 폴드8의 글로벌 시장 점유율 독점 소식", "스마트폰 메모리 반도체 가격 하락에 따른 신제품 출고가 인하", "애플 CEO 존 터너스의 사임과 신임 CEO 선임 발표"]'::json,
    '애플의 첫 폴더블폰 ''아이폰 듀오'' 공개 및 주요 스펙과 가격, 시장 영향',
    '기사는 애플이 새로 발표한 첫 폴더블폰 아이폰 듀오의 성능, 특징, 경쟁사(삼성)와의 가격·스펙 비교, 시장에 미칠 영향을 다루고 있습니다.',
    '기사의 제목과 각 문단에서 공통적으로 설명하는 핵심 기기를 생각해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    2
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '한국 시장에서 아이폰 듀오와 갤럭시Z 폴드8 최저가 모델의 가격 격차가 미국보다 크게 벌어진 이유는 무엇인가요?',
    'multiple_choice',
    '["삼성전자는 국내 가격을 미국보다 낮춘 반면, 애플은 출고가를 높게 책정했기 때문", "한국 정부가 외산 스마트폰에만 높은 수입 관세를 부과했기 때문", "애플이 한국 시장에만 2TB 모델만 단독으로 출시했기 때문", "삼성전자가 국내에서 사은품을 대량 지급하여 가격을 보전했기 때문"]'::json,
    '삼성전자는 국내 가격을 미국보다 낮춘 반면, 애플은 출고가를 높게 책정했기 때문',
    '7문단에 "삼성전자는 국내 가격을 미국보다 크게 낮춘 반면, 애플은 출고가를 높게 책정하면서 한국에서 격차가 더 벌어진 것이다"라고 설명되어 있습니다.',
    '7문단 마지막 문장을 읽고 한국 가격 차이가 커진 배경을 확인하세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    2
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '아이폰 듀오는 갤럭시Z 폴드8보다 무게가 가볍고 두께가 얇아 휴대성 측면에서 앞선다고 볼 수 있다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '6문단에 "휴대성은 삼성이 앞선다. 아이폰 듀오는 ... 갤럭시Z 폴드8보다 1.6㎜ 두껍고 53g 무겁다"라고 하였으므로 아이폰이 더 두껍고 무겁습니다.',
    '6문단에서 휴대성 평가와 두께·무게 수치 비교를 읽어보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    2
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"애플이 폴더블폰 시장에 진출함에 따라 프리미엄 스마트폰 전체 시장의 파이가 커질 수도 있지만, 한편으로는 삼성전자의 기존 (                      )을 잠식할 위험도 공존한다."',
    'multiple_choice',
    '["점유율", "부채율", "원가율", "세율"]'::json,
    '점유율',
    '9문단에서 "폴더블폰 시장을 주력 프리미엄 제품군으로 키울 수 있지만, 반대로 삼성의 점유율을 잠식할 가능성도 크다"라는 내용이 나옵니다.',
    '9문단 중반부에서 경쟁 심화로 인해 삼성이 잃을 수 있는 시장 지분을 생각해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    2
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '기사의 내용 전개 순서로 가장 바르게 연결된 것은 무엇인가요?',
    'multiple_choice',
    '["애플 신제품 행사의 신임 CEO 등장 및 제품 공개 -> 스펙 및 외신 평가 -> 갤럭시와의 비교 및 가격 -> 시장에 미칠 영향 및 경쟁사 반응", "갤럭시와의 비교 및 가격 -> 애플 신제품 행사의 신임 CEO 등장 -> 스펙 및 외신 평가 -> 시장에 미칠 영향", "시장에 미칠 영향 -> 애플 신제품 행사의 신임 CEO 등장 -> 갤럭시와의 비교 및 가격 -> 스펙 및 외신 평가", "스펙 및 외신 평가 -> 갤럭시와의 비교 및 가격 -> 애플 신제품 행사의 신임 CEO 등장 -> 시장에 미칠 영향"]'::json,
    '애플 신제품 행사의 신임 CEO 등장 및 제품 공개 -> 스펙 및 외신 평가 -> 갤럭시와의 비교 및 가격 -> 시장에 미칠 영향 및 경쟁사 반응',
    '1~2문단 신제품 발표, 3~5문단 스펙/외신 평가, 6~8문단 갤럭시 비교 및 가격, 9~10문단 시장 파급력 및 삼성 반응 순으로 전개됩니다.',
    '행사 장면으로 시작해 스펙, 가격 비교, 시장 반응으로 이어지는 글의 흐름을 확인해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    2
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] 반대로 삼성의 점유율을 잠식할 가능성도 크다.

[문제] 위 문단에서 ''잠식(蠶食)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["점점 침범하여 차고 들어감", "공정하게 수수료를 나누어 가짐", "새로운 상품을 신속하게 개발함", "품질을 개선하여 가격을 올림"]'::json,
    '점점 침범하여 차고 들어감',
    '''잠식''은 누에가 뽕잎을 먹어 들어가듯 조금씩 점령하거나 차고 들어가는 것을 뜻합니다.',
    '애플의 시장 참여가 삼성의 지분을 점점 빼앗을 수 있다는 맥락을 떠올려 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    2
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] 화면 속 실루엣이 선명해지면서 애플의 새로운 CEO 존 터너스가 모습을 드러냈다.

[문제] 위 문단의 ''실루엣(silhouette)''은 ''윤곽이나 검은 그림자 모양''을 뜻하는 말로 바르게 쓰였습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''실루엣''은 그림자처럼 기획 영상 속 인물의 어두운 윤곽 모양을 뜻하므로 문맥상 맞습니다.',
    '베일에 가려진 인물의 윤곽이 드러나는 장면을 생각해 보세요.',
    'room',
    'vocab',
    'vocab_appropriateness',
    2
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] 갤럭시는 화면을 3분할할 수 있지만, 아이폰 듀오는 2개로 제한된다.

[문제] 아이폰 듀오는 화면을 3개로 나누어 다중 작업을 실행할 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '6문단에 "아이폰 듀오는 2개로 제한된다"라고 나와 있어 3분할은 불가능합니다.',
    '6문단 두 번째 문장에서 화면 분할 개수 제한을 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    2
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] 국내 출시 기준, 갤럭시Z 폴드8 256GB 모델의 가격은 227만8100원이며, 아이폰 듀오 256GB 모델은 329만원입니다.

[문제] 최저가 모델 간의 국내 가격 차이는 얼마인가요? (원 단위 포함 작성, 예: 101만1900원)',
    'short_answer',
    '[]'::json,
    '101만1900원',
    '7문단에서 "최저가 모델끼리 비교하면 아이폰 듀오가 101만1900원 비싸다"라고 설명하고 있습니다.',
    '7문단 중반부에서 최저가 비교 차액 수치를 찾아보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    2
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] 현장에서 실물을 체험한 외신들은 디자인과 화면 완성도에 높은 점수를 줬다. 정보기술(IT)매체 엔가젯은 "애플이 10년 만에 내놓은 가장 흥미로운 기기"라고 평가했다. 특히 화면을 접고 펼칠 때 콘텐트가 자연스레 이어지도록 한 전환 효과는 ''예술''이라고 호평했다.

[문제] 위 문단의 중심 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["아이폰 듀오 실물에 대한 외신들의 디자인 및 화면 완성도 호평", "외신들의 아이폰 듀오 카메라 성능 저하에 대한 비판", "아이폰 듀오의 화면 배터리 소모 문제 지적", "엔가젯의 애플 기기 불매 운동 제안"]'::json,
    '아이폰 듀오 실물에 대한 외신들의 디자인 및 화면 완성도 호평',
    '문단 전체가 아이폰 듀오의 디자인, 화면 자연스러움, 감춰진 주름 등 외신들의 긍정적인 평가를 전달하고 있습니다.',
    '외신들의 평가 반응과 인용구 내용을 종합해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    2
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] 삼성전자 미국법인의 공식 모바일 계정은 엑스(X)에 "우리가 이미 만든 거, 이제야 데워드시네요", "아직까지 달라진 게 없다"는 글을 올리며 애플의 뒤늦은 시장 진입을 꼬집었다.

[문제] 위 문단의 내용에 가장 잘 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["“우리가 만든 거 이제 데워먹나”… 삼성의 뼈있는 애플 저격", "삼성전자 미국법인, 애플과의 합작 제품 출시 공식 발표", "엑스(X) 플랫폼의 스마트폰 광고 수익 급증 현상", "애플의 삼성전자 기술 저작권 공식 침해 소송 제기"]'::json,
    '“우리가 만든 거 이제 데워먹나”… 삼성의 뼈있는 애플 저격',
    '삼성전자가 애플의 폴더블폰 시장 진입에 대해 재치 있게 풍자하며 견제구를 날린 행동을 서술하고 있습니다.',
    '삼성전자가 엑스에 올린 유머러스한 비판 문구의 핵심을 담은 제목을 찾아보세요.',
    'room',
    'core_understanding',
    'core_title',
    2
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] 아이폰 듀오는 고가의 출고가에도 불구하고 지문인식 센서를 전면 스크린 내부가 아닌 제품 ____ 측면에 탑재했다.

[문제] 문맥상 빈칸에 들어갈 두 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '측면',
    '4문단에 "얼굴인식 대신 측면 지문인식을 채택했다"라고 설명되어 있습니다.',
    '4문단 마지막 문장에서 지문인식이 위치한 부위를 확인하세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    2
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] 이번 행사에서 애플은 199만원부터 시작하는 프로·프로맥스와 329만원짜리 듀오만 공개했는데, 업계에선 메모리 반도체 등 부품값이 오르자 수익성 높은 고가 제품에 우선순위를 둔 것으로 보고 있다.

[문제] 위 문단을 통해 추론할 수 있는 것은 무엇인가요?',
    'multiple_choice',
    '["부품 단가 상승에 대응해 애플이 고급형 제품 위주의 판매로 마진을 확보하려 한다.", "메모리 반도체 가격 하락으로 인해 저가형 아이폰 생산량이 크게 늘어났다.", "애플은 이번 행사에서 보급형 라인업을 사상 최저가로 대량 출시했다.", "부품값 인상에도 불구하고 애플의 전체 수익성은 크게 악화될 것이다."]'::json,
    '부품 단가 상승에 대응해 애플이 고급형 제품 위주의 판매로 마진을 확보하려 한다.',
    '부품 원가 상승 시기에 고가·고수익성 라인업을 앞세워 기업의 마진(수익성)을 보전하려는 전략을 추론할 수 있습니다.',
    '부품값 상승과 고가 제품 중심 공개라는 두 요인의 연관성을 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    2
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] (A) 카운터포인트리서치는 폴더블폰 시장에서 올해 애플이 점유율 25%로 삼성전자를 추격할 것으로 보았다.
(B) 글로벌 시장조사업체 IDC는 내년 말 애플의 폴더블폰 점유율이 40%에 이를 것으로 전망했다.

[문제] (A)와 (B) 두 수치 전망의 관계를 가장 잘 설명한 것은 무엇인가요?',
    'multiple_choice',
    '["올해 예상 점유율(A)에 이어 내년 말 더 높아질 점유율(B)을 제시하며 애플의 가파른 성장을 단계적으로 보여준다.", "(A)의 주장을 (B)에서 완전히 상반되는 통계로 반박하고 있다.", "(A)는 과거 실적 데이터이며 (B)는 삼성전자의 목표 수치이다.", "(A)와 (B)는 동일한 기관에서 발표한 서로 다른 제품의 가격 정보이다."]'::json,
    '올해 예상 점유율(A)에 이어 내년 말 더 높아질 점유율(B)을 제시하며 애플의 가파른 성장을 단계적으로 보여준다.',
    '올해(25%)와 내년 말(40%)의 점유율 전망치를 순차적으로 제시하여 애플의 시장 침투 속도가 가파를 것임을 보여주는 구조입니다.',
    '시간의 흐름(올해 -> 내년 말)에 따른 수치 변화를 관찰해 보세요.',
    'room',
    'structure',
    'structure_order',
    2
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '갤폴드보다 101만원 비싸다…“원 모어 띵” 애플 폴더블 통할까'),
    '[문단] 미국 시장에서는 두 제품의 최저가 차이가 100달러 수준에 불과했다. [ ㄱ ] 국내 시장에서는 두 제품 간의 격차가 100만 원 이상으로 크게 벌어졌다.

[문제] [ ㄱ ] 위치에 들어갈 문맥상 가장 적절한 접속어는 무엇인가요?',
    'multiple_choice',
    '["하지만", "따라서", "예를 들어", "마치"]'::json,
    '하지만',
    '미국 시장에서의 적은 가격 차이와 한국 시장에서의 큰 가격 차이가 서로 대비되므로 대조의 접속어 ''하지만''이 적절합니다.',
    '미국과 한국 시장의 서로 다른 가격 격차 상황이 대조를 이루는지 확인해 보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    2
);

-- 기사(''소아와 달라진 성인 폐렴균…"성인 맞춤형" 백신 필요성 커져'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '기사에 등장한 ''집단면역''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["사회 구성원 다수가 면역력을 가져 감염병 확산이 억제되는 상태", "특정 개인 혼자만 백신을 맞아 병에 걸리지 않는 상태", "병원에 입원한 환자들끼리 서로 면역을 나누어 가지는 상태", "소아에게만 적용되고 성인에게는 나타나지 않는 면역 체계"]'::json,
    '사회 구성원 다수가 면역력을 가져 감염병 확산이 억제되는 상태',
    '집단면역은 다수의 구성원이 면역을 가짐으로써 감염병의 전파가 차단되어 면역이 없는 사람도 보호받는 상태를 뜻합니다.',
    '소아에게 백신을 광범위하게 접종하면서 성인에서도 감염이 줄어든 효과를 나타내는 단어입니다.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    1
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '기사의 "질환 부담이 크다"에서 ''부담(負擔)''과 가장 뜻이 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["부응", "해소", "무게", "지원"]'::json,
    '무게',
    '''질환 부담''에서 부담은 해당 질병으로 인해 짊어져야 하는 물리적·심리적·경제적 ''무게(또는 어려움)''를 의미합니다.',
    '고령층에서 폐렴구균으로 인해 겪게 되는 위험이나 해로움의 크기를 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    1
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '폐렴구균에 의해 발생하는 침습성 질환은 국내 70세 이상 고령층에서 사망률이 25~30% 수준으로 높아집니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '4문단에 "전체 사망률은 약 15%이며 75세 이상에서는 25~30% 수준으로 높아진다"라고 나와 있어 True입니다.',
    '4문단에서 고령층 사망률 수치를 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '한국MSD의 성인 특화 폐렴구균 백신인 ''캡박시브''가 직접 포함하고 있는 혈청형의 개수는 몇 가인가요?',
    'multiple_choice',
    '["10가", "15가", "20가", "21가"]'::json,
    '21가',
    '7문단에 "한국MSD의 ''캡박시브''는 성인에 특화해 설계된 21가 폐렴구균 단백접합백신이다"라고 명시되어 있습니다.',
    '7문단 첫 번째 문장에서 캡박시브의 혈청형 개수를 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    1
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '캡박시브가 식품의약품안전처의 허가를 받은 해의 월은 몇 월인가요? (숫자와 월을 함께 작성, 예: 8월)',
    'short_answer',
    '[]'::json,
    '8월',
    '9문단 첫 번째 문장에 "캡박시브는 지난해 8월 식품의약품안전처 허가를 받아"라고 나와 있습니다.',
    '9문단에서 식약처 허가를 받은 달(월)을 확인하세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '이 기사의 핵심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["유행하는 혈청형 변화에 따른 ''성인 맞춤형'' 폐렴구균 백신(캡박시브)의 필요성과 특징", "소아 예방접종 완전 무료화에 따른 국내 폐렴구균 질환 소멸 소식", "65세 이상 고령층의 폐렴구균 백신 접종 중단 권고", "20가 폐렴구균 백신의 글로벌 시장 점유율 독점 현황"]'::json,
    '유행하는 혈청형 변화에 따른 ''성인 맞춤형'' 폐렴구균 백신(캡박시브)의 필요성과 특징',
    '소아 백신 접종 확대로 유행하는 혈청형이 변함에 따라 성인에게 특화된 21가 백신(캡박시브)의 필요성과 임상 결과 등을 다루고 있습니다.',
    '제목과 도입부에서 강조하는 성인 맞춤형 백신의 도입 배경을 종합해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    1
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '소아 백신 접종이 확대된 후 나타난 ''혈청형 대체'' 현상에 대한 설명으로 옳은 것은 무엇인가요?',
    'multiple_choice',
    '["기존 백신에 포함된 혈청형 감염은 줄고, 포함되지 않은 혈청형 감염은 늘어나는 현상", "모든 폐렴구균 혈청형이 소멸하고 새로운 바이러스로 변종되는 현상", "소아에게 유행하던 혈청형이 성인에게 전혀 감염되지 않게 되는 현상", "기존 백신의 유효기간이 지나서 면역력이 자동으로 사라지는 현상"]'::json,
    '기존 백신에 포함된 혈청형 감염은 줄고, 포함되지 않은 혈청형 감염은 늘어나는 현상',
    '1문단과 6문단에 따르면, 기존 백신에 포함된 혈청형은 감소했지만 포함되지 않은 혈청형 감염이 서서히 증가하는 현상을 혈청형 대체라고 합니다.',
    '1문단 마지막 문장과 6문단의 설명을 확인해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    1
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '미국 데이터에 따르면 65세 이상 성인에게 21가 백신은 20가 백신보다 더 높은 원인 혈청형 커버리지(포함 비율)를 보인다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '8문단에서 미국 자료 기준 65세 이상에서 20가 백신은 약 50%, 21가 백신은 약 84%를 포함한다고 하였으므로 21가 백신의 커버리지가 더 높음을 알 수 있습니다.',
    '8문단 마지막 문장의 수치를 비교해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    1
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"과거와 달리 소아와 성인에서 유행하는 폐렴구균 혈청형이 서로 달라짐에 따라, 이제는 성인의 유행 양상에 맞춰 특화된 (                      ) 백신을 활용하는 것이 효과적이다."',
    'multiple_choice',
    '["성인 맞춤형", "소아 전용", "영유아용", "동물 전용"]'::json,
    '성인 맞춤형',
    '기사 제목과 문단 전반에서 성인 질환 및 성인 유행 혈청형을 겨냥한 성인 맞춤형 백신의 중요성을 강조하고 있습니다.',
    '기사의 제목에 사용된 대표 수식어를 생각해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    1
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '이 기사의 글 전개 순서로 가장 바르게 연결된 것은 무엇인가요?',
    'multiple_choice',
    '["혈청형 대체 현상 발생 원인 -> 폐렴구균 질환의 위험성 -> 21가 백신(캡박시브)의 등장 및 특징 -> 국내 권고 및 임상 결과", "국내 권고 및 임상 결과 -> 폐렴구균 질환의 위험성 -> 혈청형 대체 현상 발생 원인 -> 21가 백신(캡박시브)의 등장", "21가 백신(캡박시브)의 등장 -> 혈청형 대체 현상 발생 원인 -> 국내 권고 및 임상 결과 -> 폐렴구균 질환의 위험성", "폐렴구균 질환의 위험성 -> 국내 권고 및 임상 결과 -> 혈청형 대체 현상 발생 원인 -> 21가 백신(캡박시브)의 등장"]'::json,
    '혈청형 대체 현상 발생 원인 -> 폐렴구균 질환의 위험성 -> 21가 백신(캡박시브)의 등장 및 특징 -> 국내 권고 및 임상 결과',
    '1~2문단에서 혈청형 대체 현상을 소개하고, 3~4문단 질환 위험성, 7~8문단 캡박시브 특징, 9~11문단 권고안 및 임상 성과 순으로 설명합니다.',
    '글의 도입부부터 임상 결과가 제시되는 마지막 부분까지의 흐름을 확인해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    1
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] 캡박시브는 20가 백신과 공통된 10개 혈청형 모두에서 면역원성 비열등성을 입증했다.

[문제] 위 문단에서 ''면역원성(免疫原性)''의 뜻으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["체내에 들어와 면역 반응을 일으키게 하는 성질", "백신을 접종했을 때 발생하는 부작용의 강도", "세균이 약물에 대해 저항하고 살아남는 능력", "혈액 속의 산소를 운반하는 단백질의 농도"]'::json,
    '체내에 들어와 면역 반응을 일으키게 하는 성질',
    '''면역원성''은 항원이 생체 내에 들어갔을 때 면역 반응(항체 생성 등)을 유발하는 성질을 뜻합니다.',
    '백신이 몸 안에서 항체를 형성하고 면역을 만들어 내는 능력을 의미합니다.',
    'room',
    'vocab',
    'vocab_meaning',
    1
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] 기존 백신이 겨냥하지 않은 혈청형에 의한 감염은 증가했다.

[문제] 위 문단의 ''겨냥하지''는 ''목표나 대상으로 삼지''라는 의미로 바르게 사용되었습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''겨냥하다''는 어떤 대상을 목표로 정하다라는 뜻이므로 문맥상 옳습니다.',
    '백신이 특정 혈청형을 예방 목표로 삼는지 여부를 나타냅니다.',
    'room',
    'vocab',
    'vocab_appropriateness',
    1
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] 국내 연구에서는 21가 백신이 침습성 폐렴구균질환 원인 혈청형의 약 75%를 포함하는 것으로 나타났다. 20가 백신은 약 57%로 약 15~17%포인트(p) 차이가 있었다.

[문제] 국내 연구 결과, 20가 백신은 침습성 폐렴구균질환 원인 혈청형의 약 75%를 커버합니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '문단에 따르면 75%를 포함하는 것은 21가 백신이며, 20가 백신은 약 57%를 포함합니다.',
    '8문단에서 21가 백신과 20가 백신의 수치를 서로 비교해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    1
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] 대한감염학회 성인 예방접종 권고안에 따르면 국내 65세 이상 성인에게 20가 또는 21가 단백접합백신을 몇 회 접종하도록 권고하고 있나요? (숫자와 회를 작성, 예: 1회)',
    'short_answer',
    '[]'::json,
    '1회',
    '9문단 마지막 문장에 "국내에서는 65세 이상 성인에게 20가 또는 21가 단백접합백신을 1회 접종하도록 권고하고 있다"라고 명시되어 있습니다.',
    '9문단 마지막 문장에서 권고 접종 횟수를 확인하세요.',
    'room',
    'info_extraction',
    'info_evidence',
    1
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] 폐렴구균은 사람의 비인두에 존재하다 폐렴이나 중이염, 부비동염 등을 일으킬 수 있다. 혈액이나 뇌수막으로 침투하면 패혈증·뇌수막염 등 침습성 폐렴구균질환으로 이어질 수 있다. 현재까지 알려진 혈청형은 100개 이상이다.

[문제] 위 문단의 핵심 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["폐렴구균이 유발하는 주요 질환과 알려진 혈청형의 수", "폐렴구균 치료제의 개발 역사와 오남용의 위험성", "소아 중이염 수술의 최신 기법과 성공률", "뇌수막염 치료를 위한 항생제 투여 가이드라인"]'::json,
    '폐렴구균이 유발하는 주요 질환과 알려진 혈청형의 수',
    '문단은 폐렴구균이 일으킬 수 있는 구체적인 질환들(폐렴, 중이염, 패혈증 등)과 혈청형의 개수를 설명하고 있습니다.',
    '문단에 나열된 질환 이름들과 혈청형 종류 수에 주목해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    1
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] 김 교수는 "전체적으로 폐렴구균 감염이 줄어들었지만 백신 혈청형에 포함되지 않는 혈청형에 의한 감염은 서서히 증가하고 있다"며 "이것을 우리가 혈청형 대체라고 한다"고 강조했다.

[문제] 위 문단의 내용에 가장 잘 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["백신 미포함 혈청형 감염의 증가… ''혈청형 대체''란 무엇인가", "소아 예방접종 중단에 따른 감염병 재유행 위험성", "기존 백신의 완전한 치료 효과와 접종 종료 선언", "폐렴구균 백신의 생산 공정 단축 방안 발표"]'::json,
    '백신 미포함 혈청형 감염의 증가… ''혈청형 대체''란 무엇인가',
    '백신에 포함되지 않은 혈청형 감염이 늘어나는 현상인 ''혈청형 대체'' 개념을 설명하는 문단입니다.',
    '김 교수가 강조한 핵심 개념어인 ''혈청형 대체''가 포함된 제목을 찾아보세요.',
    'room',
    'core_understanding',
    'core_title',
    1
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] 캡박시브는 성인에게 많이 발생하는 혈청형을 위주로 맞춤 설계되었기 때문에, 소아 접종 백신에 포함되지 않아 새로 늘어난 혈청형 감염을 예방하는 데 ____ 효과를 발휘할 것으로 기대된다.

[문제] 문맥상 빈칸에 들어갈 두 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '높은',
    '성인 특화 백신이 증가된 미포함 혈청형을 직접 겨냥하고 있으므로 예방 효과가 ''높을'' 것으로 추론하는 것이 타당합니다.',
    '성인에 특화되어 설계되었다는 점이 예방 능력에 어떤 영향을 줄지 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    1
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] 임상에서도 면역원성과 안전성을 확인했다. 폐렴구균 백신 접종 경험이 없는 18세 이상 성인 2656명을 대상으로 한 3상 ''STRIDE-3''에서 캡박시브는 20가 백신과 공통된 10개 혈청형 모두에서 면역원성 비열등성을 입증했다.

[문제] 위 문단을 통해 알 수 있는 사실로 옳지 않은 것은 무엇인가요?',
    'multiple_choice',
    '["캡박시브의 임상 3상 시험은 백신을 접종한 적이 있는 사람만을 대상으로 시행되었다.", "캡박시브는 20가 백신과 공통된 10개 혈청형에서 기존 백신 못지않은 면역 반응을 보였다.", "임상 시험 대상자는 18세 이상 성인 2656명이었다.", "STRIDE-3 임상 시험을 통해 백신의 안전성과 면역원성을 확인했다."]'::json,
    '캡박시브의 임상 3상 시험은 백신을 접종한 적이 있는 사람만을 대상으로 시행되었다.',
    '문단에서 "폐렴구균 백신 접종 경험이 없는 18세 이상 성인"을 대상으로 임상을 진행했다고 명시되어 있으므로 옳지 않은 설명입니다.',
    '임상 대상자의 백신 접종 경험 유무를 문단에서 확인해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    1
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] (A) 캡박시브는 지난해 8월 식약처 허가를 받아 올해 3월 국내 출시됐다.
(B) 지난 5월 대한감염학회 성인 예방접종 권고안에도 캡박시브가 포함됐다.

[문제] (A)와 (B) 문장의 시간적·논리적 연결 관계로 가장 자연스러운 것은 무엇인가요?',
    'multiple_choice',
    '["식약처 허가 및 출시(A) 이후 학회의 예방접종 권고안 포함(B)으로 이어진 순차적 전개", "학회 권고안 포함(B)이 먼저 일어난 후 식약처 허가(A)가 취소된 역순 전개", "(A)와 (B)는 서로 아무런 관련이 없는 별개의 해외 허가 사례 나열", "백신 개발 포기(A)로 인해 학회 권고안에서 제외(B)된 과정 설명"]'::json,
    '식약처 허가 및 출시(A) 이후 학회의 예방접종 권고안 포함(B)으로 이어진 순차적 전개',
    '국내 허가 및 출시(8월/3월) 이후 성인 예방접종 권고안 반영(5월)으로 이어지는 시기적 흐름을 보여줍니다.',
    '각 사건이 일어난 연월 순서(지난해 8월 -> 올해 3월 -> 지난 5월)를 확인해 보세요.',
    'room',
    'structure',
    'structure_order',
    1
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '소아와 달라진 성인 폐렴균…''성인 맞춤형'' 백신 필요성 커져'),
    '[문단] 소아 백신 접종으로 기존 혈청형 감염이 감소했다. [ ㄱ ] 백신에 포함되지 않은 새로운 혈청형에 의한 감염이 늘어나며 ''혈청형 대체'' 현상이 나타났다.

[문제] [ ㄱ ] 위치에 들어갈 접속어로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["반면에", "그러므로", "예를 들어", "마치"]'::json,
    '반면에',
    '기존 혈청형 감염 감소와 미포함 혈청형 감염 증가라는 대비되는 현상을 연결하므로 대조의 접속어 ''반면에''가 가장 적절합니다.',
    '앞 문장의 ''감소''와 뒤 문장의 ''증가''라는 상반된 변화를 이어주는 말을 찾아보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    1
);

-- 기사(''쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '기사에 등장한 ''일교차(日較差)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["하루 동안의 가장 높은 기온과 가장 낮은 기온의 차이", "오늘의 기온과 내일의 기온 사이에 발생하는 차이", "서울의 기온과 제주도의 기온 사이에 발생하는 차이", "여름철 기온과 가을철 기온의 평균적인 차이"]'::json,
    '하루 동안의 가장 높은 기온과 가장 낮은 기온의 차이',
    '일교차는 하루(24시간) 동안 기록된 최저기온과 최고기온의 차이를 의미합니다.',
    '낮과 밤 사이에 벌어지는 기온의 차이를 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    1
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '기사의 "선선하고 쾌청한 가을 날씨"에서 ''쾌청(快晴)한''과 뜻이 가장 가까운 표현은 무엇인가요?',
    'multiple_choice',
    '["하늘이 맑고 기분이 상쾌한", "구름이 많고 매우 어두운", "비바람이 세차게 불어오는", "안개가 자욱하여 앞이 보이지 않는"]'::json,
    '하늘이 맑고 기분이 상쾌한',
    '쾌청하다는 하늘에 구름이 적고 날씨가 아주 맑아서 상쾌하다는 뜻입니다.',
    '비 소식 없이 맑고 가을볕이 비치는 날씨를 뜻합니다.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    1
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '기상청에 따르면 일요일인 9월 13일 오후부터 밤사이 제주도 산지에 비가 내릴 가능성이 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '2문단 마지막 문장에 "다만 일요일인 13일 오후부터 밤사이 제주도 산지에 비가 내릴 가능성이 있다"라고 명시되어 있으므로 O입니다.',
    '2문단 끝부분에서 제주도 비 예보 내용을 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '9월 11일 서울의 아침 최저기온과 낮 최고기온의 예상 일교차는 약 몇 도인가요?',
    'multiple_choice',
    '["5도", "8도", "13도", "20도"]'::json,
    '13도',
    '3문단에서 "11일에는 서울의 아침 기온이 15도로 시작해 한낮에 28도까지 올라 일교차가 13도가량 나겠다"라고 설명합니다.',
    '3문단의 서울 예보 기온(15도와 28도) 차이를 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    1
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '일부 수치예보모델에서 태풍이 발생해 북상할 가능성이 있다고 전망한 날짜는 9월 몇 일인가요? (숫자만 작성)',
    'short_answer',
    '[]'::json,
    '17',
    '4문단에서 "일부 수치예보모델이 17일 일본 남쪽에서 태풍이 발생해 북상할 가능성을 내놨지만"이라고 언급되어 있습니다.',
    '4문단에서 태풍 발생 가능성이 언급된 날짜 수치를 확인하세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '이 기사의 핵심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["당분간 비 소식 없이 쾌청하고 일교차가 큰 가을 날씨 지속 전망", "한반도를 직접 타격하는 대형 태풍의 발생 및 피해 예보", "전국적인 집중호우로 인한 수해 대책 마련 촉구", "제주도 전역에 발령된 장마전선 주의보 현황"]'::json,
    '당분간 비 소식 없이 쾌청하고 일교차가 큰 가을 날씨 지속 전망',
    '북쪽 찬 공기의 영향으로 당분간 비 소식 없이 쾌청하지만 내륙을 중심으로 일교차가 큰 날씨가 지속될 것이라는 예보를 다루고 있습니다.',
    '제목과 도입부에서 전달하는 전체적인 날씨 전망을 종합해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    1
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '맑은 날 내륙 지역을 중심으로 일교차가 10~15도로 크게 벌어지는 원인으로 옳은 것은 무엇인가요?',
    'multiple_choice',
    '["낮에는 가을볕에 지표면이 빠르게 데워지고 해가 지면 열이 빠르게 식기 때문", "남쪽 북태평양고기압이 확장하면서 고온 다습한 공기를 매일 공급하기 때문", "강한 비구름대가 연속으로 통과하며 기온 변화가 불규칙하게 일어나기 때문", "태풍이 북상하여 찬 공기와 따뜻한 공기를 주기적으로 섞어주기 때문"]'::json,
    '낮에는 가을볕에 지표면이 빠르게 데워지고 해가 지면 열이 빠르게 식기 때문',
    '3문단에서 "맑은 날엔 낮 동안 가을볕에 지표면이 빠르게 데워지고 해가 지면 열이 빠르게 식기 때문이다"라고 일교차가 큰 원인을 분명히 밝히고 있습니다.',
    '3문단 두 번째 문장에서 지표면의 열 흡수와 방출에 대한 내용을 확인하세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    1
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '기사에 따르면 9월 14일부터 20일까지의 전국 낮 최고기온 예보는 예년 기온 수준과 큰 차이가 없다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '3문단 마지막 문장에서 "14~20일 전국의 아침 최저기온은 14~22도, 낮 최고기온은 23~30도로 예년과 비슷한 수준이다"라고 명시되어 있어 O입니다.',
    '3문단 끝부분에서 예년 기온과의 비교 설명을 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    1
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"우리나라는 한반도 북쪽 고기압의 영향권에 들어 당분간 차고 (                      ) 공기가 유입되어 맑은 날씨가 이어질 전망이다."',
    'multiple_choice',
    '["건조한", "습한", "무더운", "탁한"]'::json,
    '건조한',
    '2문단에서 "북쪽 고기압 또는 그 가장자리의 영향권에 들어 차고 건조한 공기가 유입되겠다"라고 나와 있습니다.',
    '2문단 두 번째 문장에서 찬 공기와 함께 유입되는 공기의 성질을 찾아보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    1
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '이 기사의 글 전개 순서로 가장 바르게 연결된 것은 무엇인가요?',
    'multiple_choice',
    '["전반적인 가을 날씨 요약 -> 기압계 배치 및 건조 공기 유입 -> 기온 전망 및 일교차 원인 -> 다음 주 후반 변수(태풍 전망)", "다음 주 후반 변수(태풍 전망) -> 기온 전망 및 일교차 원인 -> 기압계 배치 및 건조 공기 유입 -> 전반적인 가을 날씨 요약", "기온 전망 및 일교차 원인 -> 전반적인 가을 날씨 요약 -> 다음 주 후반 변수(태풍 전망) -> 기압계 배치 및 건조 공기 유입", "기압계 배치 및 건조 공기 유입 -> 다음 주 후반 변수(태풍 전망) -> 전반적인 가을 날씨 요약 -> 기온 전망 및 일교차 원인"]'::json,
    '전반적인 가을 날씨 요약 -> 기압계 배치 및 건조 공기 유입 -> 기온 전망 및 일교차 원인 -> 다음 주 후반 변수(태풍 전망)',
    '1문단에서 전체적인 날씨 상황을 요약하고, 2문단 기압계 상황, 3문단 세부 기온과 일교차 원인, 4문단 태풍 변수로 글이 순차적으로 전개됩니다.',
    '기사의 첫 문단부터 마지막 문단까지의 서술 순서를 차례대로 따라가 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    1
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] 당분간 우리나라는 북쪽 고기압 또는 그 가장자리의 영향권에 들어 차고 건조한 공기가 유입되겠다.

[문제] 위 문단에서 ''유입(流入)''의 뜻으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["외부에서 안으로 흘러 들어옴", "안에서 외부로 빠져나감", "한곳에 고여 움직이지 않음", "서로 다른 두 물질이 섞임"]'::json,
    '외부에서 안으로 흘러 들어옴',
    '''유입''은 안으로 흘러 들어오는 것을 의미합니다.',
    '공기가 우리나라 영역 안으로 들어오는 모습을 의미합니다.',
    'room',
    'vocab',
    'vocab_meaning',
    1
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] 기압계 변동성이 커 예단하긴 이르다.

[문제] 위 문단의 ''예단(豫斷)하긴''은 ''어떤 일을 미리 판단하긴''이라는 뜻으로 문맥상 적절하게 사용되었습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''예단하다''는 미리 예측하여 판단하다라는 뜻이므로 문맥에 잘 들어맞습니다.',
    '태풍 발생 여부를 아직 확정하여 판단할 수 없다는 맥락입니다.',
    'room',
    'vocab',
    'vocab_appropriateness',
    1
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] 10일 기상청에 따르면 한반도 북쪽 고기압은 더 강해지며 확장했고 남쪽 북태평양고기압은 일본 남동쪽 해상 멀리까지 물러난 상황이다.

[문제] 위 문단에 따르면 한반도 남쪽의 북태평양고기압은 한반도 근처까지 더욱 강하게 확장하였습니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '문단에 따르면 북태평양고기압은 일본 남동쪽 해상 멀리까지 물러난 상태입니다.',
    '2문단 첫 문장에서 북태평양고기압의 위치 변화를 확인하세요.',
    'room',
    'info_extraction',
    'info_consistency',
    1
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] 주말인 12, 13일은 아침 최저기온이 12~21도, 낮 최고기온이 24~31도로 예보됐다.

[문제] 주말에는 남부지방에서 낮 기온이 몇 도 이상으로 오르겠나요? (숫자와 도를 작성, 예: 25도)',
    'short_answer',
    '[]'::json,
    '30도',
    '3문단 네 번째 문장에 "주말에는 남부지방에서 낮 기온이 30도 이상으로 오르겠다"라고 제시되어 있습니다.',
    '3문단 네 번째 문장에서 남부지방 낮 최고기온 수치를 찾으세요.',
    'room',
    'info_extraction',
    'info_evidence',
    1
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] 다음 주에도 낮과 밤의 기온차는 내륙을 중심으로 10~15도 벌어지겠다. 맑은 날엔 낮 동안 가을볕에 지표면이 빠르게 데워지고 해가 지면 열이 빠르게 식기 때문이다.

[문제] 위 문단의 핵심 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["내륙 지역의 일교차가 크고 그 이유가 지표면 열 방출 및 흡수 때문이라는 설명", "남부 지방에 내린 폭우로 인해 지표면 온도가 낮아진 현상", "가을철 해수면 온도 상승으로 인한 해안가 습도 증가 현상", "전국적으로 가뭄이 심해지며 발생한 농작물 피해 대책"]'::json,
    '내륙 지역의 일교차가 크고 그 이유가 지표면 열 방출 및 흡수 때문이라는 설명',
    '문단은 내륙 지역의 큰 일교차 폭(10~15도)과 그 원인을 명확하게 설명하고 있습니다.',
    '문단에 언급된 일교차 범위와 그 원인 문장에 주목해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    1
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] 다음 주 후반 날씨의 변수는 태풍 발생 여부다. 일부 수치예보모델이 17일 일본 남쪽에서 태풍이 발생해 북상할 가능성을 내놨지만 기압계 변동성이 커 예단하긴 이르다.

[문제] 위 문단의 내용에 가장 잘 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["다음 주 후반의 기상 변수… 태풍 발생 및 북상 가능성", "한반도 관통 확정… 대형 태풍 긴급 대피령 발령", "일본 내륙을 강타한 가을 태풍의 엄청난 피해 규모", "수치예보모델의 완성으로 정밀해진 일기예보 기술"]'::json,
    '다음 주 후반의 기상 변수… 태풍 발생 및 북상 가능성',
    '다음 주 후반에 날씨 변수가 될 수 있는 태풍 발생 가능성에 대한 짧은 관망 문단입니다.',
    '문단 첫 문장에서 강조한 날씨의 핵심 변수가 무엇인지 확인해 보세요.',
    'room',
    'core_understanding',
    'core_title',
    1
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] 9월 20일까지 전국에 별다른 비 예보가 없어 당분간 쾌청한 날씨가 이어지겠지만, 낮과 밤의 기온차가 커 환절기 ____ 관리에 주의해야 한다.

[문제] 문맥상 빈칸에 들어갈 두 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '건강',
    '일교차가 10도 이상 크게 나면 감기나 면역력 저하 등의 위험이 있으므로 환절기 ''건강'' 관리가 필요하다는 추론이 가장 자연스럽습니다.',
    '큰 일교차와 관련하여 사람이 주의해야 할 기본 요소를 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    1
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] 당분간 우리나라는 북쪽 고기압 또는 그 가장자리의 영향권에 들어 차고 건조한 공기가 유입되겠다. 하늘은 맑거나 가끔 구름 많은 날이 반복되겠다. 20일까지 전국엔 별다른 비 예보가 없다.

[문제] 위 문단을 바탕으로 추론할 수 있는 사실로 옳은 것은 무엇인가요?',
    'multiple_choice',
    '["당분간 전국적으로 야외 활동을 하기에 비교적 무난하고 맑은 날씨가 이어질 것이다.", "전국적인 집중호우로 인해 야외 행사가 모두 취소될 것이다.", "북쪽 고기압 때문에 전국에 강한 눈보라가 밀려올 것이다.", "매일 밤마다 장마비가 내릴 것이다."]'::json,
    '당분간 전국적으로 야외 활동을 하기에 비교적 무난하고 맑은 날씨가 이어질 것이다.',
    '20일까지 별다른 비 예보가 없고 맑거나 구름 약간 있는 날씨가 계속된다고 하였으므로 야외 활동에 무난한 날씨임을 추론할 수 있습니다.',
    '비 소식이 없는 맑은 가을 날씨의 영향을 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    1
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] (A) 맑은 날엔 낮 동안 가을볕에 지표면이 빠르게 데워진다.
(B) 해가 지면 지표면의 열이 빠르게 식는다.
(C) 그 결과 내륙을 중심으로 낮과 밤의 기온차가 10~15도로 크게 벌어진다.

[문제] (A), (B), (C)의 논리적 원인과 결과 순서로 가장 바른 것은 무엇인가요?',
    'multiple_choice',
    '["(A) -> (B) -> (C)", "(C) -> (A) -> (B)", "(B) -> (A) -> (C)", "(A) -> (C) -> (B)"]'::json,
    '(A) -> (B) -> (C)',
    '낮에 지표면이 데워지고(A), 밤에 식어서(B), 최종적으로 낮과 밤의 기온차가 벌어지는(C) 시간적·원인결과적 흐름이 바릅니다.',
    '낮의 온도 상승 -> 밤의 온도 하강 -> 최종 일교차 발생의 순서를 따라가 보세요.',
    'room',
    'structure',
    'structure_order',
    1
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '쾌청한 가을 날씨 열흘 더 간다… 비 소식 없이 일교차 커'),
    '[문단] 20일까지 전국엔 별다른 비 예보가 없다. [ ㄱ ] 일요일인 13일 오후부터 밤사이 제주도 산지에 비가 내릴 가능성이 있다.

[문제] [ ㄱ ] 위치에 들어갈 접속어로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["다만", "따라서", "왜냐하면", "게다가"]'::json,
    '다만',
    '전국적으로 비가 없다는 일반적 설명 뒤에 제주도 산지라는 예외적인 구역의 비 소식을 덧붙이므로 예외나 대조의 접속어 ''다만''이 가장 적절합니다.',
    '전국 예보 뒤에 제주도라는 예외 지역의 비 가능성을 덧붙이는 접속어를 찾아보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    1
);

-- 기사(''"문학은 ''마지막 흑마법''… AI시대에도 안전"'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '기사에서 라바투트 작가가 표현한 문학이 AI 시대에도 지니는 특별한 매력이나 힘을 비유한 단어인 ''흑마법''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["인간의 실제 고통과 야생성이 담긴 독창적이고 비밀스러운 힘", "컴퓨터 프로그램이 자동으로 시를 만들어 내는 기술", "남을 해치기 위해 사용하는 위험한 주문", "바둑 기사가 승리하기 위해 사용하는 기계적 계산법"]'::json,
    '인간의 실제 고통과 야생성이 담긴 독창적이고 비밀스러운 힘',
    '라바투트 작가는 AI 시스템과 대비하여 인간의 실제 경험과 내면의 고통이 담긴 문학의 독창적인 가치를 비유적으로 ''흑마법''이라 표현했습니다.',
    '기사에서 AI와 대비되는 인간의 실제 경험과 고통을 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    1
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '기사의 "AI가 급부상하고 일상 속에 계속해서 침투하고 있는"에서 ''침투(浸透)하고''와 뜻이 가장 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["파고들고", "도망치고", "단절되고", "차단되고"]'::json,
    '파고들고',
    '''침투하다''는 깊숙이 스며들거나 파고들어 퍼지는 것을 의미하므로 ''파고들고''와 뜻이 가장 가깝습니다.',
    '일상 속으로 들어와 퍼져 나가는 모습을 의미합니다.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    1
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '라바투트 작가는 2023년 소설 ''매니악''에서 바둑 기사 이세돌을 다루었습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '2문단에서 "2023년 소설 ''매니악''을 통해서는 AI 알파고와 대국을 펼친 바둑 기사 이세돌을 다뤘다"라고 언급되어 있으므로 O입니다.',
    '2문단 중간에서 작가의 소설 작품 내용을 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '2026 서울국제작가축제의 개막대담 ''사람입니다''에서 라바투트 작가와 함께 대담을 나누는 한국 소설가는 누구인가요?',
    'multiple_choice',
    '["김애란", "이세돌", "데이먼 갤것", "히라노 게이치로"]'::json,
    '김애란',
    '3문단에서 "라바투트는 11일 소설가 김애란과 함께 개막대담 ''사람입니다''에서 AI 시대 ''인간성''에 대해 논할 예정이다"라고 나옵니다.',
    '3문단 첫 번째 문장에서 개막대담을 함께하는 한국 작가 이름을 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    1
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '2026 서울국제작가축제가 열리는 장소는 어디인가요? (OO구 OO아트센터 형태로 작성)',
    'short_answer',
    '[]'::json,
    '종로구 아라아트센터',
    '3문단 첫 번째 문장에 "서울 종로구 아라아트센터에서 열리는 서울국제작가축제"라고 명시되어 있습니다.',
    '3문단에서 행사 개최 위치를 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '이 기사의 핵심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["AI 시대에도 대체될 수 없는 문학의 가치와 서울국제작가축제 소식", "AI 바둑 프로그램 알파고의 승리 원인과 기술 분석", "해외 작가들의 국내 번역 출판 시장 독점 현상", "서울국제작가축제의 입장권 판매 및 행사장 위치 안내"]'::json,
    'AI 시대에도 대체될 수 없는 문학의 가치와 서울국제작가축제 소식',
    '기사는 칠레 작가 라바투트의 인터뷰를 통해 AI 시대에 인간 경험이 담긴 문학의 가치를 설명하고, 서울국제작가축제 개막 소식을 다루고 있습니다.',
    '제목과 라바투트 작가의 발언 내용을 종합해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    1
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '라바투트 작가가 "문학은 AI로부터 완전히 안전하다"고 주장하는 주요 근원은 무엇인가요?',
    'multiple_choice',
    '["문학에는 심장 없는 시스템이 흉내 낼 수 없는 인간의 고통과 실제 경험이 담겨 있기 때문", "AI는 아직 한글과 스페인어 같은 복잡한 언어를 번역할 수 없기 때문", "작가들이 AI 기술을 활용하여 더 빠르게 소설을 쓸 수 있게 되었기 때문", "AI가 개발되는 속도보다 문학 책의 출판 속도가 더 빠르기 때문"]'::json,
    '문학에는 심장 없는 시스템이 흉내 낼 수 없는 인간의 고통과 실제 경험이 담겨 있기 때문',
    '2문단에서 "인간의 고통, 실제 경험이 묻어나는 문학을 우리는 읽고 싶어 한다"라며 인간적 고통과 경험이 문학의 본질임을 언급했습니다.',
    '2문단의 바둑 예시와 함께 언급된 인간 문학의 특징을 생각해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    1
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '라바투트 작가는 사람들이 인간 기사의 대국보다 AI끼리의 바둑 대국을 훨씬 더 보고 싶어 한다고 생각한다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '2문단에서 "그 누구도 AI끼리 바둑을 두는 모습을 보고 싶어 하지 않듯이"라고 말하여, 사람들이 AI끼리의 대결보다 인간의 경험과 감정이 들어간 모습을 원한다고 보았습니다.',
    '2문단에서 작가가 사용한 비유("누구도 AI끼리 바둑을 두는 모습을...")를 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    1
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '다음 빈칸에 들어갈 말로 가장 적절한 것은 무엇인가요?
"라바투트 작가는 AI가 일상에 침투하는 시대일수록 기계적 결정이 아닌, 인간 본연의 (                      )와 내면의 감정을 회복해야 한다고 강조했다."',
    'multiple_choice',
    '["야생성", "알고리즘", "효율성", "기계화"]'::json,
    '야생성',
    '2문단 마지막 문장에서 "이 시대 우리가 무엇보다 야생성과 내면의 분노를 다시 회복해야 한다"라고 말했습니다.',
    '2문단 끝부분에서 작가가 회복해야 한다고 강조한 단어를 찾으세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    1
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '이 기사의 글 전개 순서로 가장 바르게 연결된 것은 무엇인가요?',
    'multiple_choice',
    '["라바투트 작가의 핵심 발언(AI와 문학) -> 기자간담회에서의 구체적 비유와 견해 -> 축제 개최 정보 및 개막대담 안내", "축제 개최 정보 및 개막대담 안내 -> 라바투트 작가의 핵심 발언(AI와 문학) -> 기자간담회에서의 구체적 비유와 견해", "기자간담회에서의 구체적 비유와 견해 -> 축제 개최 정보 및 개막대담 안내 -> 라바투트 작가의 핵심 발언(AI와 문학)", "축제 개최 정보 및 개막대담 안내 -> 기자간담회에서의 구체적 비유와 견해 -> 라바투트 작가의 핵심 발언(AI와 문학)"]'::json,
    '라바투트 작가의 핵심 발언(AI와 문학) -> 기자간담회에서의 구체적 비유와 견해 -> 축제 개최 정보 및 개막대담 안내',
    '도입부에서 작가의 인용구로 시작해, 2문단에서 기자간담회 발언 내용을 상세히 다루고, 3문단에서 행사 기간 및 대담 일정으로 마무리됩니다.',
    '각 문단이 인용구부터 시작해 행사 안내로 끝나는 흐름을 확인해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    1
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] 라바투트는 11일 소설가 김애란과 함께 개막대담 ''사람입니다''에서 AI 시대 ''인간성''에 대해 논할 예정이다.

[문제] 위 문단의 ''대담(對談)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["마주하여 서로 말씀을 나누함", "여러 사람이 모여 서로 크게 다툼", "혼자서 청중을 향해 길게 연설함", "서면으로 질문을 주고받는 행위"]'::json,
    '마주하여 서로 말씀을 나누함',
    '''대담''은 서로 마주 앉아서 이야기를 주고받는 것을 의미합니다.',
    '두 사람이 만나서 대화를 나누는 모습을 떠올려 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    1
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] 11∼16일 서울 종로구 아라아트센터에서 열리는 서울국제작가축제에서는 이 같은 논의가 확장된다.

[문제] 위 문단의 ''확장(擴張)된다''는 ''범위나 규모가 넓어져 늘어난다''는 의미로 바르게 사용되었습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''확장되다''는 범위나 규모 따위가 넓어져 늘어나다라는 뜻으로 문맥상 적절합니다.',
    '대담과 축제를 통해 논의의 주제나 범위가 더 넓어짐을 의미합니다.',
    'room',
    'vocab',
    'vocab_appropriateness',
    1
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] 칠레 소설가 벵하민 라바투트는 한국문학번역원이 개최하는 ''2026 서울국제작가축제''를 위해 한국을 찾아 이같이 말했다.

[문제] 2026 서울국제작가축제를 개최한 기관은 한국문학번역원이다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '2문단 첫 문장에 "한국문학번역원이 개최하는 ''2026 서울국제작가축제''"라고 명시되어 있습니다.',
    '2문단에서 축제를 주최/개최하는 기관 이름을 확인하세요.',
    'room',
    'info_extraction',
    'info_consistency',
    1
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] 데이먼 갤것, 히라노 게이치로 등 해외 작가 10명과 한국 작가 14명이 참여해 독자들과 만난다.

[문제] 이번 서울국제작가축제에 참여하는 해외 작가는 모두 몇 명인가요? (숫자와 명을 작성, 예: 5명)',
    'short_answer',
    '[]'::json,
    '10명',
    '3문단 마지막 문장에 "해외 작가 10명과 한국 작가 14명이 참여해"라고 나와 있습니다.',
    '3문단 끝부분에서 해외 작가의 수를 찾아보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    1
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] 라바투트는 과학기술의 발전사 속에 존재했던 인간에 주목해온 작가다. 2023년 소설 ''매니악''을 통해서는 AI 알파고와 대국을 펼친 바둑 기사 이세돌을 다뤘다.

[문제] 위 문단이 설명하는 라바투트 작가의 특징으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["과학기술 발전사 속 인간의 존재와 삶에 관심이 깊은 작가", "AI 알고리즘을 개발하여 직접 프로그램을 제작하는 컴퓨터 공학자", "바둑 기사 이세돌의 실제 바둑 스승이자 코치", "소설 작성을 중단하고 과학 교과서를 작성하는 연구원"]'::json,
    '과학기술 발전사 속 인간의 존재와 삶에 관심이 깊은 작가',
    '문단 첫 문장에서 작가가 과학기술 발전사 속의 인간에 주목해 왔음을 명확히 설명하고 있습니다.',
    '문단 첫 문장의 "과학기술의 발전사 속에 존재했던 인간에 주목해온 작가"에 집중하세요.',
    'room',
    'core_understanding',
    'core_topic',
    1
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] 10일 열린 기자간담회에서 그는 "그 누구도 AI끼리 바둑을 두는 모습을 보고 싶어 하지 않듯이, 인간의 고통, 실제 경험이 묻어나는 문학을 우리는 읽고 싶어 한다"고 말했다.

[문제] 위 문단의 내용을 가장 잘 표현한 소제목은 무엇인가요?',
    'multiple_choice',
    '["인간의 실제 고통과 경험이 담긴 문학을 원하는 이유", "AI 바둑 알고리즘의 발전 과정과 한계점", "기자간담회 개최 소식과 참가자 명단 발표", "바둑 기사들의 경기 관람률 감소 현상"]'::json,
    '인간의 실제 고통과 경험이 담긴 문학을 원하는 이유',
    '기자간담회에서 라바투트 작가가 밝힌 문학 소비의 핵심 원인(인간의 고통과 경험)을 담은 소제목입니다.',
    '사람들이 왜 AI가 아닌 인간의 문학을 읽고 싶어하는지에 대한 작가의 말을 떠올려 보세요.',
    'room',
    'core_understanding',
    'core_title',
    1
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] 심장 없이 결정을 내리는 시스템(AI)과 달리, 문학은 감정과 고통을 가진 ____이 만드는 작품이라는 점에서 대체될 수 없는 독자성을 지닌다.

[문제] 문맥상 빈칸에 들어갈 두 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '인간',
    '기사 전반에서 기계 시스템(AI)과 대비되는 주체로서 ''인간''의 경험과 고통을 강조하고 있습니다.',
    '심장 없는 AI와 대비되어 고통과 경험을 느끼는 존재를 의미합니다.',
    'room',
    'inference_judgment',
    'inference_blank',
    1
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] 라바투트는 11일 소설가 김애란과 함께 개막대담 ''사람입니다''에서 AI 시대 ''인간성''에 대해 논할 예정이다. 데이먼 갤것, 히라노 게이치로 등 해외 작가 10명과 한국 작가 14명이 참여해 독자들과 만난다.

[문제] 위 문단을 통해 알 수 있는 서울국제작가축제의 특징으로 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["국내외 작가들이 함께 모여 시대적 화두인 ''인간성''과 문학을 논하는 교류의 장이다.", "한국 작가들만 참여하여 국내 문학 발전 방향만 일방적으로 발표한다.", "작가들이 AI에게 작문 기술을 배우는 강좌 형태로 개최된다.", "해외 유명 작가 1명만을 초청하여 진행하는 독주회 형식의 행사이다."]'::json,
    '국내외 작가들이 함께 모여 시대적 화두인 ''인간성''과 문학을 논하는 교류의 장이다.',
    '국내외 여러 작가들이 모여 AI 시대의 인간성에 관해 논하고 독자들과 만나는 축제임을 알 수 있습니다.',
    '참여하는 작가들의 구성(국내외)과 논의 주제(인간성)를 종합해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    1
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] (A) 라바투트는 과학기술의 발전사 속에 존재했던 인간에 주목해온 작가다.
(B) 2023년 소설 ''매니악''을 통해서는 AI 알파고와 대국을 펼친 바둑 기사 이세돌을 다뤘다.

[문제] (A)와 (B) 두 문장의 관계를 가장 잘 설명한 것은 무엇인가요?',
    'multiple_choice',
    '["(A) 작가의 전반적인 작품 경향 설명 -> (B) 이를 뒷받침하는 구체적인 대표작 사례 제시", "(A) 작가의 미래 계획 발표 -> (B) 과거에 포기했던 작업의 이유 설명", "(A) 다른 작가의 평가 소개 -> (B) 라바투트 작가의 반론 제시", "(A) 바둑 경기 결과 요약 -> (B) 과학기술의 역사적 배경 설명"]'::json,
    '(A) 작가의 전반적인 작품 경향 설명 -> (B) 이를 뒷받침하는 구체적인 대표작 사례 제시',
    '(A)에서 작가가 인간에 주목해 왔다는 일반적 경향을 말하고, (B)에서 이세돌을 다룬 소설 ''매니악''이라는 구체적 사례를 들고 있습니다.',
    '일반적 특징 제시 후 구체적 소설 작품을 예시로 든 관계입니다.',
    'room',
    'structure',
    'structure_order',
    1
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '“문학은 ‘마지막 흑마법’… AI시대에도 안전”'),
    '[문단] 라바투트는 "문학은 인공지능으로부터 완전히 안전하다"고 보았다. [ ㄱ ] 심장 없이 결정을 내리는 시스템과 달리 문학에는 인간의 실제 고통이 묻어있기 때문이다.

[문제] [ ㄱ ] 위치에 들어갈 접속어로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["왜냐하면", "그러나", "그렇지만", "결국"]'::json,
    '왜냐하면',
    '앞 문장의 주장에 대해 뒤 문장에서 이유와 근거를 설명하고 있으므로 원인을 나타내는 접속어 ''왜냐하면''이 가장 적절합니다.',
    '앞 문장(주장)과 뒤 문장(이유) 사이의 인과관계를 생각해 보세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    1
);

-- 기사(''[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '기사에 등장한 ''환절기(換節期)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["계절이 바뀌는 시기", "한 해 중 가장 더운 시기", "비가 연속해서 많이 내리는 시기", "낮의 길이가 밤보다 긴 시기"]'::json,
    '계절이 바뀌는 시기',
    '환절기는 여름에서 가을, 가을에서 겨울처럼 계절이 바꾸어 바뀌는 시기를 뜻합니다.',
    '여름에서 가을로 넘어가는 시기를 의미합니다.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    1
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '기사의 "선선한 초가을 날씨"에서 ''선선한''과 뜻이 가장 가까운 표현은 무엇인가요?',
    'multiple_choice',
    '["시원하고 기분 좋을 정도로 서늘한", "피부가 아플 정도로 몹시 추운", "땀이 날 정도로 무덥고 습한", "바람이 없어 푹푹 증기 같은"]'::json,
    '시원하고 기분 좋을 정도로 서늘한',
    '선선하다는 것은 바람이나 날씨가 시원하고 서늘하다는 의미입니다.',
    '초가을의 시원하고 서늘한 느낌을 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    1
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '오늘 서울의 아침 기온은 13도선까지 내려가 올가을 들어 가장 쌀쌀했습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '캐스터 발언 첫 문장에서 "오늘 아침 서울은 기온이 13도선까지 내려가며, 올가을 들어 가장 쌀쌀했습니다"라고 명시되어 있으므로 O입니다.',
    '오늘 아침 서울 기온 관련 내용을 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '기사에 언급된 설악산과 대관령 등 높은 산지의 아침 기온은 몇 도 안팎이었나요?',
    'multiple_choice',
    '["5도 안팎", "10도 안팎", "15도 안팎", "20도 안팎"]'::json,
    '5도 안팎',
    '본문에서 "설악산과 대관령 등 높은 산지는 5도 안팎까지 내려가 이미 초겨울에 가까워져있고요"라고 밝히고 있습니다.',
    '높은 산지 지역의 아침 기온 숫자를 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    1
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '기사 중 수도권 지역에서 대기가 건조하여 특별히 주의해달라고 당부한 항목은 무엇인가요? (OO 관리)',
    'short_answer',
    '[]'::json,
    '불씨',
    '본문 후반부에 "수도권은 대기도 건조한 만큼, 불씨 관리 잘 해주셔야겠습니다"라고 언급되어 있습니다.',
    '건조한 날씨와 관련된 화재 예방 단어를 생각해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '이 기사의 핵심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["주말까지 이어지는 쾌청한 초가을 날씨와 큰 일교차 유의 당부", "전국적인 대형 태풍 상륙에 따른 기상 특보 발령", "수도권 밤사이 폭우 예보 및 침수 피해 대책", "초겨울 한파 경보 발령과 폭설 대비 안내"]'::json,
    '주말까지 이어지는 쾌청한 초가을 날씨와 큰 일교차 유의 당부',
    '전체 기사는 주말까지 맑고 선선한 날씨가 지속되는 가운데 일교차가 매우 커 건강 및 차림새 관리가 필요하다는 내용을 전하고 있습니다.',
    '제목과 앵커 멘트의 핵심 메시지를 종합해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    1
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '기상캐스터가 일교차가 큰 가을 날씨에 대비하여 권장한 옷차림 방안은 무엇인가요?',
    'multiple_choice',
    '["외투 한 벌을 챙겨 다녀 체온 조절하기", "낮에도 두꺼운 패딩점퍼를 계속 입기", "체온 유지를 위해 하루 종일 우비 착용하기", "아침 일찍부터 얇은 반소매 차림만 유지하기"]'::json,
    '외투 한 벌을 챙겨 다녀 체온 조절하기',
    '본문에서 "일교차가 큰 만큼, 외투 한벌 챙겨다니시는 편이 좋겠습니다" 및 "일교차에 대비한 옷차림으로 체온 조절 잘 해주시기 바랍니다"라고 강조합니다.',
    '캐스터가 광화문광장 시민들의 차림새를 보며 권장한 사항을 확인하세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    1
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '기사에 따르면 가을철 맑은 날에는 구름 사이로 강한 가을볕이 내리쬐어 자외선 지수가 높아질 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '본문에서 "구름 사이로 가을 볕이 강하게 내리쬐며 자외선 지수가 높겠고요"라고 직접 언급되었으므로 O입니다.',
    '가을볕과 자외선 지수에 관한 언급을 찾아보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    1
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '다음 빈칸에 들어갈 가장 적절한 단어는 무엇인가요?
"오늘 아침은 쌀쌀했지만 낮부터는 기온이 빠르게 올라 아침과 낮의 기온 차이가 10도 이상으로 크므로, (                      )에 걸리지 않도록 건강 관리에 유의해야 한다."',
    'multiple_choice',
    '["감기", "식중독", "열사병", "냉방병"]'::json,
    '감기',
    '기사 마지막 부분에서 "계절이 바뀌며 감기 걸리기 쉬운 날씨니까요"라고 일교차가 클 때 주의할 질환으로 감기를 제시하고 있습니다.',
    '환절기 일교차가 클 때 걸리기 쉬운 대표적인 질환을 생각해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    1
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '이 기사의 방송 진행 순서로 가장 바르게 연결된 것은 무엇인가요?',
    'multiple_choice',
    '["앵커 도입부 -> 아침/현재 기온 비교 -> 낮 기온 및 일교차 설명 -> 하늘 상태/주의사항 -> 주말 날씨 및 마무리", "주말 날씨 및 마무리 -> 하늘 상태/주의사항 -> 앵커 도입부 -> 낮 기온 및 일교차 설명 -> 아침/현재 기온 비교", "하늘 상태/주의사항 -> 앵커 도입부 -> 아침/현재 기온 비교 -> 주말 날씨 및 마무리 -> 낮 기온 및 일교차 설명", "아침/현재 기온 비교 -> 앵커 도입부 -> 주말 날씨 및 마무리 -> 낮 기온 및 일교차 설명 -> 하늘 상태/주의사항"]'::json,
    '앵커 도입부 -> 아침/현재 기온 비교 -> 낮 기온 및 일교차 설명 -> 하늘 상태/주의사항 -> 주말 날씨 및 마무리',
    '앵커의 개요 소개 후, 캐스터가 아침·현재 기온, 낮 기온과 일교차, 자외선/건조 등 주의사항, 주말 예보와 당부 멘트로 순차 진행합니다.',
    '앵커 연결부터 캐스터의 마무리 멘트까지의 글 순서를 따라가 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    1
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] 오늘 전국적으로 비 예보 없이, 하늘 대체로 맑게 드러나 있습니다. 구름 사이로 가을 볕이 강하게 내리쬐며 자외선 지수가 높겠고요.

[문제] 위 문단에서 ''자외선(紫外線)''에 대한 설명으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["태양광 중 가시광선보다 파장이 짧아 눈에 보이지 않지만 피부나 눈에 영향을 주는 빛", "지구 내부에서 발생하여 지표면으로 방출되는 열에너지", "비구름을 형성하여 대기를 습하게 만드는 수증기 입자", "바람을 일으켜 대기를 시원하게 만들어 주는 기류"]'::json,
    '태양광 중 가시광선보다 파장이 짧아 눈에 보이지 않지만 피부나 눈에 영향을 주는 빛',
    '자외선은 태양 빛의 한 종류로 피부 타기나 자극을 유발하는 광선입니다.',
    '햇빛에 노출될 때 주의해야 하는 광선입니다.',
    'room',
    'vocab',
    'vocab_meaning',
    1
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] 주말인 내일도 쾌청한 하늘 아래, 선선한 가을 날씨 만끽하기 좋겠습니다.

[문제] 위 문단의 ''만끽(滿喫)하기''는 ''마음껏 누리고 즐기기''라는 뜻으로 문맥상 바르게 쓰였습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''만끽하다''는 좋은 날씨나 기분을 마음껏 누린다는 뜻이므로 문맥에 맞습니다.',
    '좋은 가을 날씨를 마음껏 누린다는 맥락입니다.',
    'room',
    'vocab',
    'vocab_appropriateness',
    1
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] 이 시각 기온, 서울이 23.2도, 청주 24.5도, 대구 25.5도 보이고 있는데요. 아침과 낮, 낮과 밤의 기온 차가 10도 이상으로 크겠습니다.

[문제] 위 방송 중 중계 시각의 서울 기온은 25.5도였습니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '방송 시각 기준 서울 기온은 23.2도이고, 25.5도는 대구 기온입니다.',
    '문단에서 제시된 서울 기온 수치를 다시 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    1
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] 파주 10도, 서울 13.4도 등 중부 내륙은 올가을 들어 가장 쌀쌀했습니다.

[문제] 위 문단에서 아침 기온이 10도로 언급된 중부 내륙 지역은 어디인가요?',
    'short_answer',
    '[]'::json,
    '파주',
    '문단에 "파주 10도"라고 명확히 기재되어 있습니다.',
    '10도라는 기온 수치 바로 앞에 나온 지명을 찾으세요.',
    'room',
    'info_extraction',
    'info_evidence',
    1
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] 오늘 전국적으로 비 예보 없이, 하늘 대체로 맑게 드러나 있습니다. 구름 사이로 가을 볕이 강하게 내리쬐며 자외선 지수가 높겠고요. 수도권은 대기도 건조한 만큼, 불씨 관리 잘 해주셔야겠습니다.

[문제] 위 문단의 중심 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["맑은 하늘 속 자외선 주의와 수도권의 건조함에 따른 불씨 관리 당부", "전국적인 집중호우 예보와 강풍 피해 우려 사항 안내", "남부 지방의 습도 증가와 안개 주의보 발령 현황", "갑작스러운 가을 한파로 인한 농작물 냉해 예방 대책"]'::json,
    '맑은 하늘 속 자외선 주의와 수도권의 건조함에 따른 불씨 관리 당부',
    '문단은 맑은 날씨 속에 높은 자외선 지수와 수도권 대기 건조에 따른 불씨 관리 주의를 다루고 있습니다.',
    '문단에서 언급된 날씨 상태(맑음)와 두 가지 주의사항(자외선, 불씨)을 정리해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    1
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] 북쪽에서 찬 공기가 내려오면서, 일부 산지와 내륙 지역은 한 자릿수 기온으로 출발했습니다. 설악산과 대관령 등 높은 산지는 5도 안팎까지 내려가 이미 초겨울에 가까워져있고요.

[문제] 위 문단에 가장 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["북쪽 찬 공기 유입… 산지·내륙 쌀쌀한 아침 기온", "전국 해수욕장 피서객으로 인산인해", "남부 지방 폭염특보 확대 지정", "가을장마 시작… 산간 지역 집중호우"]'::json,
    '북쪽 찬 공기 유입… 산지·내륙 쌀쌀한 아침 기온',
    '문단은 찬 공기 유입으로 산지 및 내륙 지역의 아침 기온이 한 자릿수까지 떨어진 상황을 다룹니다.',
    '아침 기온이 떨어진 원인과 영향이 잘 담긴 제목을 골라보세요.',
    'room',
    'core_understanding',
    'core_title',
    1
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] 현재 광화문광장에는 낮 동안 올라간 기온으로 반소매 차림의 시민들이 많지만, 해가 지면 기온이 급격히 떨어지므로 체온을 유지할 수 있는 ____을(를) 가지고 다니는 것이 좋다.

[문제] 기사의 내용에 비추어 빈칸에 들어갈 가장 적절한 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '외투',
    '기사 본문에서 "일교차가 큰 만큼, 외투 한벌 챙겨다니시는 편이 좋겠습니다"라고 제안하고 있습니다.',
    '쌀쌀한 아침·저녁에 입을 수 있는 겉옷을 의미합니다.',
    'room',
    'inference_judgment',
    'inference_blank',
    1
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] 주말인 내일도 쾌청한 하늘 아래, 선선한 가을 날씨 만끽하기 좋겠습니다. 계절이 바뀌며 감기 걸리기 쉬운 날씨니까요. 환절기 건강 관리 잘 해주시기 바랍니다.

[문제] 위 문단을 읽고 추론한 내용으로 옳지 않은 것은 무엇인가요?',
    'multiple_choice',
    '["주말 동안에는 강한 비바람이 불어 야외 활동이 불가능할 것이다.", "주말에 야외로 나들이를 가기에 날씨가 좋을 것이다.", "환절기에는 면역력이 떨어져 감기에 걸릴 위험이 높아진다.", "계절 변화에 따른 체온 관리가 중요하다."]'::json,
    '주말 동안에는 강한 비바람이 불어 야외 활동이 불가능할 것이다.',
    '문단에서 내일도 쾌청하고 선선하여 날씨를 만끽하기 좋다고 하였으므로 강한 비바람이 분다는 추론은 잘못되었습니다.',
    '내일 날씨 상태에 관한 캐스터의 설명("쾌청한 하늘")과 상반되는 보기를 찾으세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    1
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] (A) 낮부터는 기온이 빠르게 올라 예년 수준을 회복하고 있다.
(B) 오늘 아침 서울은 13도선까지 내려가 올가을 들어 가장 쌀쌀했다.
(C) 따라서 아침과 낮의 기온 차가 10도 이상으로 무척 크게 벌어진다.

[문제] 위 내용의 논리적 흐름으로 가장 적절한 순서는 무엇인가요?',
    'multiple_choice',
    '["(B) -> (A) -> (C)", "(A) -> (B) -> (C)", "(C) -> (B) -> (A)", "(B) -> (C) -> (A)"]'::json,
    '(B) -> (A) -> (C)',
    '아침에 쌀쌀했던 기온(B)이 낮에 상승하면서(A), 결국 하루 동안의 일교차가 커진다(C)는 순서가 가장 자연스럽습니다.',
    '아침 상황 -> 낮 상황 -> 그 결과(일교차 발생) 순서로 구성해 보세요.',
    'room',
    'structure',
    'structure_order',
    1
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '[날씨] 주말까지 쾌청한 초가을…15도 안팎 일교차 유의'),
    '[문단] 어제는 낮에도 서늘했습니다. [ ㄱ ] 현재는 예년 이맘때 수준을 회복하고 있습니다.

[문제] [ ㄱ ] 위치에 들어갈 문맥상 가장 적절한 접속어는 무엇인가요?',
    'multiple_choice',
    '["하지만", "그래서", "왜냐하면", "게다가"]'::json,
    '하지만',
    '어제 낮의 서늘함과 달리 현재는 예년 수준을 회복했다는 대조적인 내용이 이어지므로 역접 접속어 ''하지만''이 가장 적절합니다.',
    '어제 상황과 현재 상황 사이의 반대·대조 관계를 이어주는 접속어를 찾으세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    1
);

-- 기사(''추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '기사에 등장한 ''절정(絶頂)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["사물이나 현상의 상태가 가장 무르익거나 최고조에 달한 때", "어떤 일이 시작되기 바로 직전의 상태", "날씨가 맑아졌다가 다시 나빠지는 변덕스러운 시기", "사물이 원래 모습에서 완전히 시들어버린 상태"]'::json,
    '사물이나 현상의 상태가 가장 무르익거나 최고조에 달한 때',
    '절정은 산 전체의 나뭇잎이 가장 짙고 아름답게 물든 상태, 즉 최고조에 달한 때를 의미합니다.',
    '단풍이 산 전체의 80%가량 물들어 가장 무르익은 시기를 생각해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    1
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '기사의 "기압계 변동성이 커 예단하긴 이르다"라는 문맥에서 ''예단(豫斷)하다''와 뜻이 가장 가까운 표현은 무엇인가요?',
    'multiple_choice',
    '["미리 판단하다", "뒤늦게 후회하다", "단단히 고정하다", "자세히 조사하다"]'::json,
    '미리 판단하다',
    '예단하다는 어떤 일의 결과를 미리 짐작하여 판단한다는 뜻입니다.',
    '결과를 미리 확정하여 생각하는 것을 뜻합니다.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    1
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '기상청 기준에 따르면 산 정상에서부터 아래로 20%가량 물들었을 때를 ''첫 단풍''이라고 봅니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '◆ 연휴에 볼 수 있는 건 대청봉 일대뿐 단락에서 "산 정상에서부터 아래로 20%가량 물든 때를 첫 단풍"으로 본다고 명시되어 있으므로 O입니다.',
    '기상청의 첫 단풍 정의 비율(20%)을 본문에서 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '기사에 따르면 단풍 전선은 하루에 약 몇 ㎞씩 남쪽으로 이동하나요?',
    'multiple_choice',
    '["5~10㎞", "20~25㎞", "40~50㎞", "100㎞ 이상"]'::json,
    '20~25㎞',
    '◆ 첫 단풍은 언제? 단락에서 "단풍은 하루에 약 20∼25㎞씩 남쪽으로 내려간다"라고 설명되어 있습니다.',
    '단풍 전선의 이동 속도 수치(㎞)를 본문에서 찾으세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    1
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '행정안전부 통계에 따르면 2020~2024년 5년간 등산사고가 가장 많이 발생한 달은 몇 월인가요? (숫자만 작성)',
    'short_answer',
    '[]'::json,
    '10',
    '◆ 단풍철 두 달에 등산사고 4건 중 1건 단락에서 "10월이 5691건으로 가장 많았고"라고 명시되어 있습니다.',
    '월별 등산사고 통계에서 사고 건수가 가장 많은 달을 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '이 기사의 핵심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["평년보다 늦어진 올해 단풍 시기 전망과 단풍철 산행 시 안전 주의 당부", "전국 주요 국립공원 등산로 전면 통제 및 단풍 축제 취소 소식", "지구 온난화로 인한 전국 산림의 수종 교체 및 산불 위험성 보고", "추석 연휴 기간 동안의 전국적인 도로 정체 및 대중교통 운행 안내"]'::json,
    '평년보다 늦어진 올해 단풍 시기 전망과 단풍철 산행 시 안전 주의 당부',
    '기사는 올해 첫 단풍 및 절정 시기가 평년보다 늦어진다는 예보와 함께 단풍철 산행 사고 예방을 당부하는 내용을 골자로 합니다.',
    '단풍 시기 전망과 산행 안전 수칙을 다룬 전체 내용을 종합하세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    1
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '올해 추석 연휴에 가족들과 모여 산 전체가 물든 단풍 구경을 하기 힘든 이유로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["첫 단풍 예상이 평년보다 늦고 산 전체 절정은 10월 이후에 시작되기 때문", "추석 연휴 동안 전국 모든 국립공원이 등산객 입산을 통제하기 때문", "강한 태풍이 상륙하여 전국 산간 지역의 단풍이 모두 떨어졌기 때문", "9월 중순부터 전국적인 폭설이 내려 단풍이 덮였기 때문"]'::json,
    '첫 단풍 예상이 평년보다 늦고 산 전체 절정은 10월 이후에 시작되기 때문',
    '본문에서는 첫 단풍 예상이 9월 말~10월 초이고 산 전체가 물드는 절정은 10월 중순 이후이므로 추석 연휴 단풍 구경은 이르다고 설명합니다.',
    '추석 연휴 기간과 첫 단풍 및 절정 시기 간의 날짜 차이를 고려하세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    1
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '낙엽수는 일 최저기온이 5도 아래로 떨어져야 잎이 물드므로, 9월 이후 기온이 평년보다 높으면 단풍 시기가 늦어진다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '◆ 절정은 설악산 10월 19일, 북한산 11월 1일 단락 마지막 부분에 "일 최저기온이 5도 아래로 떨어지기 시작해야 잎이 물들기 때문에 9월 이후 기온이 높을수록 단풍도 늦어진다"라고 언급되어 있으므로 O입니다.',
    '기온과 단풍이 물드는 시기 사이의 관계를 나타낸 문장을 확인하세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    1
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '다음 빈칸에 들어갈 가장 적절한 단어는 무엇인가요?
"가을철 산행 시에는 조난 및 안전사고에 대비하여 해가 지기 전에 산행을 마치도록 시간을 넉넉히 두고, 만약의 사태에 대비해 휴대폰 (                      )와 비상 연락수단을 미리 점검해야 한다."',
    'multiple_choice',
    '["배터리", "손난로", "나침반", "삼각대"]'::json,
    '배터리',
    '기사 마지막 문단에서 "휴대전화 배터리와 비상 연락수단을 미리 점검하고"라고 안전 수칙을 권장하고 있습니다.',
    '휴대전화를 지속적으로 사용하고 연락을 유지하기 위해 점검해야 하는 요소입니다.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    1
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '이 기사의 글 전개 순서로 가장 바르게 연결된 것은 무엇인가요?',
    'multiple_choice',
    '["추석 연휴 단풍 관람 전망 요약 -> 설악산 대청봉 단풍 현황 -> 기관별 첫 단풍 및 절정 예상 시기 -> 단풍철 등산 사고 통계 및 안전 수칙", "단풍철 등산 사고 통계 및 안전 수칙 -> 기관별 첫 단풍 및 절정 예상 시기 -> 설악산 대청봉 단풍 현황 -> 추석 연휴 단풍 관람 전망 요약", "설악산 대청봉 단풍 현황 -> 추석 연휴 단풍 관람 전망 요약 -> 단풍철 등산 사고 통계 및 안전 수칙 -> 기관별 첫 단풍 및 절정 예상 시기", "기관별 첫 단풍 및 절정 예상 시기 -> 단풍철 등산 사고 통계 및 안전 수칙 -> 추석 연휴 단풍 관람 전망 요약 -> 설악산 대청봉 단풍 현황"]'::json,
    '추석 연휴 단풍 관람 전망 요약 -> 설악산 대청봉 단풍 현황 -> 기관별 첫 단풍 및 절정 예상 시기 -> 단풍철 등산 사고 통계 및 안전 수칙',
    '기사는 추석 연휴 단풍 관람이 어렵다는 도입부 요약으로 시작해, 설악산 대청봉 상황, 두 민간 업체의 상세 첫 단풍·절정 예보, 그리고 등산 사고 관련 통계 및 안전 당부로 마무리됩니다.',
    '소제목으로 구분된 각 파트의 핵심 주제가 어떤 순서로 배치되어 있는지 따라가 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    1
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] 케이웨더는 9월 중순 기온이 평년과 비슷하겠지만 하순과 10월은 평년보다 높을 것으로 봤다. 낙엽수는 일 최저기온이 5도 아래로 떨어지기 시작해야 잎이 물들기 때문이다.

[문제] 위 문단에서 ''낙엽수(落葉樹)''의 뜻으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["계절에 따라 잎이 떨어지고 새로운 잎이 나는 나무", "일년 내내 푸른 잎을 유지하는 소나무 같은 나무", "물속이나 습지에서만 자라는 수생 식물", "열매를 맺지 않고 꽃만 피우는 관상용 나무"]'::json,
    '계절에 따라 잎이 떨어지고 새로운 잎이 나는 나무',
    '낙엽수는 가을이나 겨울에 잎이 떨어졌다가 봄에 새잎이 나는 나무를 뜻하며, 단풍이 드는 대표적인 나무들입니다.',
    '가을이 되면 잎이 물들고 결국 떨어지는 나무를 의미합니다.',
    'room',
    'vocab',
    'vocab_meaning',
    1
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] 해가 지기 전에 산행을 마칠 수 있도록 시간을 넉넉히 두는 것도 당부 사항이다.

[문제] 위 문단의 ''산행(山行)''은 ''산을 오르거나 산속을 걷는 일''이라는 뜻으로 문맥상 바르게 쓰였습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''산행''은 산을 오르거나 산길을 거니는 행위를 뜻하므로 문맥에 아주 적절합니다.',
    '등산이나 산길을 걷는 행위를 나타내는 한자어입니다.',
    'room',
    'vocab',
    'vocab_appropriateness',
    1
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] 케이웨더와 웨더아이 두 민간 기관이 모두 동일하게 본 것은 단풍 전선의 속도다. 단풍은 하루에 약 20∼25㎞씩 남쪽으로 내려간다.

[문제] 위 문단에 따르면 두 기관은 단풍 전선이 남쪽으로 이동하는 속도에 대해 서로 다른 견해를 보였습니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '문단에서 "두 기관이 같게 본 것은 단풍 전선의 속도다"라고 명시했으므로 서로 다른 견해를 보였다는 설명은 X입니다.',
    '두 기관이 동일하게 판단한 항목이 무엇인지 문단에서 확인하세요.',
    'room',
    'info_extraction',
    'info_consistency',
    1
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] 2020∼2024년 5년간 등산사고 결과 424명이 숨지고 1만6852명이 다쳤으며 202명이 실종됐다.

[문제] 이 기간 등산사고로 발생한 사망자 수는 총 몇 명인가요? (숫자만 작성)',
    'short_answer',
    '[]'::json,
    '424',
    '◆ 단풍철 두 달에 등산사고 4건 중 1건 단락에서 "이 사고로 424명이 숨지고"라고 기재되어 있습니다.',
    '사고로 사망한(숨진) 사람 수치를 문단에서 찾아보세요.',
    'room',
    'info_extraction',
    'info_evidence',
    1
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] 단풍 절정은 첫 단풍이 든 뒤 2주쯤 지나 나타난다. 케이웨더는 설악산이 10월 19일, 북한산이 11월 1일쯤 가장 짙게 물들 것으로 봤다. 웨더아이는 오대산과 설악산을 10월 16∼25일로 봤다. 절정을 보려면 10월 셋째 주 이후 강원, 10월 말 이후 중부, 11월 둘째 주 남부 순으로 목적지를 잡아야 한다.

[문제] 위 문단의 중심 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["주요 산 및 지역별 단풍 절정 예상 시기와 추천 방문 일정", "전국 주요 산의 입장료 인상 및 야간 산행 금지 안내", "기후 변화로 인한 단풍나무의 집단 시듦 현상 분석", "봄철 꽃구경을 위한 전국 주요 산의 개화 시기 비교"]'::json,
    '주요 산 및 지역별 단풍 절정 예상 시기와 추천 방문 일정',
    '문단은 산별, 지역별 단풍 절정 예상 날짜와 이에 맞춰 여행 목적지를 잡는 시기를 안내하고 있습니다.',
    '문단에 제시된 산 이름들과 날짜 수치가 어떤 정보를 나타내는지 살펴보세요.',
    'room',
    'core_understanding',
    'core_topic',
    1
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] 한편 단풍을 보러 산에 오르는 사람이 늘면 사고도 함께 늘어난다. 10월과 9월 두 달간 발생한 등산사고는 5년치 전체의 24.8%로, 등산사고 4건 중 1건이 단풍철에 일어난 셈이다. 지정된 등산로를 이용하고 해가 지기 전에 산행을 마쳐야 한다.

[문제] 위 문단에 가장 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["단풍철에 집중되는 등산사고… 안전 수칙 준수 당부", "가을철 전국 산림 내 무단 야영 및 취사 행위 적발", "단풍철 맞아 신규 개설된 최단 등산 코스 소개", "전국 유명 국립공원 주변 맛집 및 숙박 시설 안내"]'::json,
    '단풍철에 집중되는 등산사고… 안전 수칙 준수 당부',
    '단풍철인 9~10월에 등산사고가 집중되므로 지정 등산로 이용 등 안전 수칙을 지켜야 한다는 점을 다룹니다.',
    '등산 사고 통계와 안전 당부라는 두 가지 핵심 단어가 들어간 소제목을 찾으세요.',
    'room',
    'core_understanding',
    'core_title',
    1
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] 같은 산이라도 정상부와 산 아래는 기온 차이로 인해 단풍이 물드는 시기가 2주 이상 벌어진다. 따라서 추석 연휴에 가족들과 함께 산 산책로를 걸으며 산 전체에 만발한 단풍을 기대하기는 ____.

[문제] 맥락상 빈칸에 들어갈 두 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '어렵다',
    '추석 연휴 시점에는 정상부 일부에만 단풍이 시작되고 산 전체 절정은 10월 이후이므로 단풍 구경이 "어렵다"(또는 힘들다)가 자연스럽습니다.',
    '추석 연휴 시점과 산 전체 단풍 절정 시기 간의 차이를 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    1
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] 민간 기상업체 케이웨더와 웨더아이가 내놓은 중부지방 및 남부지방의 첫 단풍 날짜 예측에는 차이가 존재한다. 남쪽으로 내려갈수록 두 예상의 차이는 더 벌어진다.

[문제] 위 문단을 읽고 올바르게 추론한 것은 무엇인가요?',
    'multiple_choice',
    '["기상 예측 기관에 따라 날씨 및 기온 예측 모델이 달라 단풍 시기 전망에 차이가 날 수 있다.", "남부지방은 기온 변화가 전혀 없어 두 기관 모두 똑같은 날짜를 예측했다.", "모든 기상업체는 기상청 공식 데이터만 그대로 복사하여 발표한다.", "중부지방보다 남부지방의 단풍 시기를 맞히는 것이 훨씬 쉽다."]'::json,
    '기상 예측 기관에 따라 날씨 및 기온 예측 모델이 달라 단풍 시기 전망에 차이가 날 수 있다.',
    '기관마다 분석 모델이나 기온 전망치 기준이 달라 첫 단풍 및 절정 예상 날짜에 차이가 발생함을 추론할 수 있습니다.',
    '서로 다른 기상 예측 기관의 결과가 차이 나는 이유를 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    1
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] (A) 이에 따라 강원 산간에서 시작한 단풍이 남부 지역에 닿기까지 한 달 넘게 걸린다.
(B) 단풍은 하루에 약 20∼25㎞씩 남쪽으로 천천히 이동한다.
(C) 따라서 같은 한국이라도 지역에 따라 단풍 절정 시기가 달라진다.

[문제] 위 내용의 논리적 흐름으로 가장 적절한 순서는 무엇인가요?',
    'multiple_choice',
    '["(B) -> (A) -> (C)", "(A) -> (B) -> (C)", "(C) -> (B) -> (A)", "(B) -> (C) -> (A)"]'::json,
    '(B) -> (A) -> (C)',
    '단풍의 일일 이동 속도(B)로 인해 남부까지 가는 데 한 달이 걸리고(A), 그 결과 지역별 절정 시기가 차이 난다(C)는 원인-결과 흐름이 적절합니다.',
    '이동 속도 원인 -> 이동 소요 시간 -> 최종 결과(지역별 절정 차이) 순서로 맞춰보세요.',
    'room',
    'structure',
    'structure_order',
    1
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '추석 연휴엔 단풍보다 여행으로…올해 단풍 절정 평년보다 늦어 [여행&]'),
    '[문단] 지난달 31일 대청봉 일대에서 단풍이 관측됐다. [ ㄱ ] 이것은 아직 기상청 기준의 공식적인 첫 단풍이 아니다.

[문제] [ ㄱ ] 위치에 들어갈 문맥상 가장 적절한 접속어는 무엇인가요?',
    'multiple_choice',
    '["다만", "따라서", "게다가", "마침내"]'::json,
    '다만',
    '대청봉 단풍 관측 사실과 이것이 공식 첫 단풍은 아니라는 대조/보완 내용이 연결되므로 역접·제한의 접속어 ''다만''이 들어갑니다.',
    '단풍 관측 사실과 공식 기준 미달이라는 제한적 사실을 이어주는 말을 고르세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    1
);

-- 기사(''아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '기사에 등장한 ''사전예약(事前預約)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["상품이 정식 출시되거나 서비스가 시작되기 전에 미리 구매를 약속하는 것", "제품을 다 사용한 후 정식으로 반납 절차를 진행하는 것", "중고 제품을 매장에 직접 들고 가 수리를 요청하는 것", "제품의 가격이 인하될 때까지 기다렸다가 구매하는 것"]'::json,
    '상품이 정식 출시되거나 서비스가 시작되기 전에 미리 구매를 약속하는 것',
    '사전예약은 어떤 상품이나 서비스가 세상에 정식으로 출시되기 전에 미리 신청하여 구매를 예약하는 행위를 뜻합니다.',
    '제품이 정식 출시되기 전에 미리 신청해 두는 것을 생각해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    1
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '기사의 "혜택을 내세웠다"에서 ''혜택(惠澤)''과 뜻이 가장 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["이득", "손실", "벌금", "의무"]'::json,
    '이득',
    '혜택은 할인이나 쿠폰 등 고객이 얻는 도움이나 이득을 의미합니다.',
    '고객이 통신사로부터 받는 이로운 보상이나 할인 등을 의미합니다.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    1
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '아이폰18 프로 시리즈의 사전예약은 9월 12일부터 시작되며, 공식 출시는 9월 18일입니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '1문단에 "사전예약은 12일부터 시작되며, 공식 출시는 18일이다"라고 명시되어 있으므로 O입니다.',
    '1문단에서 사전예약 시작일과 정식 출시일을 확인하세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    'KT의 단말 관리 서비스인 ''폰체인지_i18''을 이용할 경우, 2년 뒤 기존 단말을 반납하면 가입 당시 출고가의 최대 몇 %를 보장해주나요?',
    'multiple_choice',
    '["30%", "40%", "50%", "70%"]'::json,
    '50%',
    'KT 관련 3문단에서 "''폰체인지_i18''은 월 5000원으로 이용할 수 있으며, 2년 뒤 기존 단말을 반납하면 가입 당시 출고가의 최대 50%를 보장한다"라고 명시되어 있습니다.',
    'KT의 단말 반납 보장 서비스 설명에서 보장 비율(%)을 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    1
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '애플 최초의 폴더블 아이폰인 ''아이폰 듀오''의 내부 디스플레이 크기는 몇 형(인치)인가요? (숫자와 소수점만 작성, 예: 6.1)',
    'short_answer',
    '[]'::json,
    '7.6',
    '마지막 문단에 "아이폰 듀오는 7.6형 내부 디스플레이와 5.4형 외부 디스플레이를 적용하고"라고 제시되어 있습니다.',
    '기사 마지막 문단에서 아이폰 듀오의 내부 디스플레이 크기를 찾으세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '이 기사의 핵심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["아이폰18 프로 출시를 앞둔 이동통신 3사의 사전예약 혜택 및 중고폰 보상 경쟁", "스마트폰 요금제 전면 폐지 및 기본료 무상 제공 정책 발표", "삼성전자 플래그십 신제품의 세계 시장 점유율 1위 달성 소식", "애플 앱스토어의 수수료 인하에 따른 국내 개발사 반응"]'::json,
    '아이폰18 프로 출시를 앞둔 이동통신 3사의 사전예약 혜택 및 중고폰 보상 경쟁',
    '기사는 아이폰18 프로 출시 일정에 맞춰 SKT, KT, LG유플러스 이동통신 3사가 마련한 할인, 제휴카드, 서비스 등 다양한 사전예약 혜택을 다루고 있습니다.',
    '기사의 전체 내용이 통신 3사(SKT, KT, LGU+)의 사전예약 혜택에 집중되어 있음을 파악하세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    1
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    'LG유플러스가 아이폰18 프로 사전예약 고객에게 차별화 포인트로 제시한 AI 통화 서비스의 이름은 무엇인가요?',
    'multiple_choice',
    '["익시오", "T전화", "에이닷", "빅스비"]'::json,
    '익시오',
    'LG유플러스 관련 3문단에서 "개통 고객은 AI 통화앱 ''익시오''를 통해 통화 녹음·요약과 해외 음성통화를 지원하는 ''로밍콜''을 이용할 수 있다"라고 설명합니다.',
    'LG유플러스 항목에서 AI 통화앱의 명칭을 찾아보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    1
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '아이폰18 프로 사전예약 시 이동통신사 제휴카드를 활용하고 전월 실적 조건을 충족하면 단말 및 요금 할인 폭을 더 크게 넓힐 수 있다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '이통 3사 모두 제휴카드 결제 및 전월 실적 달성 시 추가 할인 및 캐시백 혜택을 크게 제공한다고 설명하고 있으므로 O입니다.',
    '통신 3사가 제공하는 제휴카드 활용 혜택을 종합적으로 생각해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    1
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '다음 빈칸에 들어갈 가장 적절한 단어는 무엇인가요?
"LG유플러스는 사전예약 개통 고객에게 AI 통화앱 익시오를 제공하여 보이스피싱 위험을 AI가 실시간으로 탐지하는 (                      ) 기능 등 차별화된 서비스를 선보인다."',
    'multiple_choice',
    '["보이스피싱 금융안심", "무료 와이파이 자동연결", "배터리 수명 연장", "화면 자동 캡처"]'::json,
    '보이스피싱 금융안심',
    'LG유플러스 단락에서 "보이스피싱 위험을 AI가 실시간으로 탐지하는 ''보이스피싱 금융안심'' 기능도 제공한다"라고 나와 있습니다.',
    'AI가 실시간으로 보이스피싱 위험을 탐지해 주는 기능의 명칭입니다.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    1
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '이 기사의 글 전개 순서로 가장 바르게 연결된 것은 무엇인가요?',
    'multiple_choice',
    '["사전예약 및 출시 일정 공개 -> SK텔레콤 혜택 -> KT 혜택 -> LG유플러스 혜택 -> 아이폰 듀오 예약 및 스펙 정보", "SK텔레콤 혜택 -> KT 혜택 -> LG유플러스 혜택 -> 사전예약 및 출시 일정 공개 -> 아이폰 듀오 예약 및 스펙 정보", "아이폰 듀오 예약 및 스펙 정보 -> 사전예약 및 출시 일정 공개 -> SK텔레콤 혜택 -> KT 혜택 -> LG유플러스 혜택", "사전예약 및 출시 일정 공개 -> 아이폰 듀오 예약 및 스펙 정보 -> LG유플러스 혜택 -> KT 혜택 -> SK텔레콤 혜택"]'::json,
    '사전예약 및 출시 일정 공개 -> SK텔레콤 혜택 -> KT 혜택 -> LG유플러스 혜택 -> 아이폰 듀오 예약 및 스펙 정보',
    '기사는 서두에 사전예약/출시 일정을 밝힌 후 SKT, KT, LGU+ 3사의 혜택을 차례로 서술하고 마지막에 폴더블 제품인 아이폰 듀오 관련 소식을 덧붙입니다.',
    '문단별로 다루고 있는 통신사 순서와 마지막 모델 정보를 순서대로 정리해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    1
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] 기존 단말을 반납하면 ''민팃 ALL 보상''과 ''쓰던 폰 추가 보상''을 통해 최대 15만원을 추가로 받을 수 있다.

[문제] 위 문단에서 ''단말(端末)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["통신망 끝에 연결되어 데이터를 주고받는 스마트폰 등의 기기", "인터넷 통신망을 설치하는 지상 전신주", "스마트폰 내부를 구성하는 반도체 회로판", "무선 통신 데이터를 전달하는 중계 안테나"]'::json,
    '통신망 끝에 연결되어 데이터를 주고받는 스마트폰 등의 기기',
    '단말(단말기)은 사용자가 통신망에 접속하여 사용하는 스마트폰, 패드 등의 통신 기기를 뜻합니다.',
    '사용자가 손에 쥐고 사용하는 휴대폰 기기를 의미합니다.',
    'room',
    'vocab',
    'vocab_meaning',
    1
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] LG유플러스는 온라인 전용 할인과 AI 통화 서비스를 차별화 포인트로 내세웠다.

[문제] 위 문단의 ''차별화(差別化)''는 ''다른 것과 구별되는 독특한 특징이나 우위를 만드는 것''이라는 뜻으로 문맥상 적절하게 쓰였습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''차별화''는 경쟁사와 구별되는 고유한 강점이나 차이점을 부각하는 것을 뜻하므로 문맥에 바르게 쓰였습니다.',
    '다른 통신사와 차이를 두는 개성 있는 강점이라는 의미입니다.',
    'room',
    'vocab',
    'vocab_appropriateness',
    1
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] 애플 최초의 폴더블 아이폰인 아이폰 듀오는 10월 16일부터 사전예약을 시작해 23일 출시됩니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '마지막 문단에 "아이폰 듀오는 10월 16일부터 사전예약을 시작해 23일 출시된다"라고 제시되어 있으므로 O입니다.',
    '기사의 마지막 문단 첫 문장을 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    1
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] SK텔레콤은 사전예약 후 개통한 고객에게 전용 T멤버십 ''클럽 아이폰18 프로''를 제공한다. 구글 AI Plus(400GB) 2개월과 티빙 광고형 스탠다드 4개월 이용권을 받을 수 있다.

[문제] 티빙 광고형 스탠다드 이용권은 몇 개월 제공되나요? (숫자만 작성)',
    'short_answer',
    '[]'::json,
    '4',
    'SK텔레콤 관련 문단에서 "티빙 광고형 스탠다드 4개월 이용권을 받을 수 있고"라고 제시되어 있습니다.',
    'SKT 혜택 중 티빙 이용권의 제공 기간(개월)을 확인하세요.',
    'room',
    'info_extraction',
    'info_evidence',
    1
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] KT는 요금제와 단말 관리 서비스를 묶은 혜택을 내세웠다. ''초이스 더블'' 요금제에 가입하면 유튜브 프리미엄 라이트, 넷플릭스, Google AI Plus, 에어팟 프로3 등 콘텐츠·AI·디바이스 혜택 가운데 원하는 조합을 선택할 수 있다.

[문제] 위 문단의 중심 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["KT의 요금제 결합 혜택 및 고객 선택형 콘텐츠·디바이스 제공 안내", "KT의 전국 5G 기지국 무료 증설 계획 발표", "유튜브 및 넷플릭스의 요금 인상에 따른 통신사 반발", "KT 알뜰폰 요금제의 가입자 수 급증 현상 분석"]'::json,
    'KT의 요금제 결합 혜택 및 고객 선택형 콘텐츠·디바이스 제공 안내',
    '문단은 KT의 ''초이스 더블'' 요금제를 통해 고객이 원하는 콘텐츠, AI, 디바이스 혜택 조합을 자유롭게 고를 수 있음을 설명합니다.',
    'KT가 제안하는 요금제 결합 선택 혜택에 주목하세요.',
    'room',
    'core_understanding',
    'core_topic',
    1
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] 한편 아이폰 듀오는 10월16일부터 사전예약을 시작해 23일 출시된다. 애플 최초의 폴더블 아이폰인 아이폰 듀오는 7.6형 내부 디스플레이와 5.4형 외부 디스플레이를 적용하고 A20 Pro 칩을 탑재했다.

[문제] 위 문단에 가장 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["애플 최초의 폴더블폰 ''아이폰 듀오''… 10월 사전예약 및 주요 스펙", "아이폰 단종 공식 발표… 신형 폴더블 전면 취소", "보급형 스마트폰 시장 확대를 위한 애플의 가성비 전략", "아이폰 듀오의 화면 결함 발생에 따른 전량 리콜 결정"]'::json,
    '애플 최초의 폴더블폰 ''아이폰 듀오''… 10월 사전예약 및 주요 스펙',
    '문단은 애플의 첫 폴더블 스마트폰인 아이폰 듀오의 출시 일정과 화면 크기, 칩셋 등 핵심 사양을 소개합니다.',
    '폴더블폰 ''아이폰 듀오''의 특징과 출시 일정이 포함된 제목을 고르세요.',
    'room',
    'core_understanding',
    'core_title',
    1
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] LG유플러스는 U+공식온라인스토어 사전예약 고객을 위해 신제품을 출시일 아침에 빠르게 받아볼 수 있는 ''____'' 서비스를 제공한다.

[문제] 맥락상 빈칸에 들어갈 네 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '아침배송',
    'LG유플러스 문단 마지막 부분에서 "출시일 아침 단말을 받아볼 수 있는 ''아침배송'' 서비스도 제공한다"라고 명시되어 있습니다.',
    '출시일 아침에 단말기를 전달해 주는 서비스 이름입니다.',
    'room',
    'inference_judgment',
    'inference_blank',
    1
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] SK텔레콤, KT, LG유플러스 모두 사전예약 고객을 유치하기 위해 기존 단말 반납 보상 혜택, 제휴카드 할인, 온라인 전용 쿠폰 등을 다채롭게 제시하고 있다.

[문제] 위 문단을 통해 추론할 수 있는 통신 시장의 상황으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["이통3사가 프리미엄 신형 아이폰 고객을 선점하기 위해 치열한 마케팅 경쟁을 벌이고 있다.", "이동통신 시장에서 아이폰 구매 수요가 완전히 사라져 사전예약 이벤트가 축소되었다.", "통신사들은 신규 가입자보다 기존 단말기를 계속 사용하는 고객에게만 혜택을 집중한다.", "제휴카드 할인 혜택이 전면 금지되어 통신사들의 마케팅 수단이 대폭 감소했다."]'::json,
    '이통3사가 프리미엄 신형 아이폰 고객을 선점하기 위해 치열한 마케팅 경쟁을 벌이고 있다.',
    '3사 모두 신형 아이폰 출시 일정에 맞춰 파격적인 할인과 보상 혜택을 내세운 것은 신규 및 변경 고객을 선점하기 위한 경쟁임을 알 수 있습니다.',
    '다양한 혜택을 다투어 공개하는 통신사들의 의도를 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    1
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] (A) 애플 최초의 폴더블폰인 아이폰 듀오는 10월 16일부터 사전예약을 시작한다.
(B) 이에 앞서 아이폰18 프로 시리즈 사전예약이 9월 12일부터 시작된다.
(C) 이에 맞춰 이통3사는 9월 11일 각사의 사전예약 혜택을 경쟁적으로 공개했다.

[문제] 시간적 흐름에 맞춘 가장 적절한 순서는 무엇인가요?',
    'multiple_choice',
    '["(C) -> (B) -> (A)", "(A) -> (B) -> (C)", "(B) -> (C) -> (A)", "(C) -> (A) -> (B)"]'::json,
    '(C) -> (B) -> (A)',
    '9월 11일 혜택 공개(C) -> 9월 12일 아이폰18 프로 사전예약(B) -> 10월 16일 아이폰 듀오 사전예약(A) 순서로 진행됩니다.',
    '날짜 순서(9월 11일 -> 9월 12일 -> 10월 16일)를 확인해 보세요.',
    'room',
    'structure',
    'structure_order',
    1
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '아이폰18 프로 고객 잡아라…이통3사 사전예약 혜택 경쟁'),
    '[문단] KT 다이렉트샵에선 최대 32% 요금할인과 24개월 무이자 할부를 지원한다. [ ㄱ ] Y덤 고객 2000명에게는 한정판 굿즈를 추첨 제공한다.

[문제] [ ㄱ ] 위치에 들어갈 문맥상 가장 적절한 접속어는 무엇인가요?',
    'multiple_choice',
    '["또한", "그러나", "왜냐하면", "반면에"]'::json,
    '또한',
    'KT 다이렉트샵의 요금 및 할부 할인 혜택에 더해, 특정 고객 대상 굿즈 추첨 혜택을 추가로 설명하고 있으므로 순접/첨가의 접속어 ''또한''이 적절합니다.',
    '앞선 혜택에 추가적인 이벤트를 덧붙일 때 쓰는 연결어를 찾으세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    1
);

-- 기사(''애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '기사에 등장한 ''PoC(Proof of Concept)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["새로운 기술이나 아이디어가 실제로 실현 가능한지 검증하는 단계", "완제품을 대량 생산하여 전 세계 시장에 판매하는 단계", "기업의 주식을 증권 시장에 공식적으로 상장하는 절차", "고장 난 제품을 무료로 수리해 주는 서비스 보증 기간"]'::json,
    '새로운 기술이나 아이디어가 실제로 실현 가능한지 검증하는 단계',
    'PoC(개념 검증)는 새로운 기술이나 아이디어를 도입하기 전에 실제 환경에서 적용 가능성과 효과를 타당성 있게 검증해 보는 단계를 뜻합니다.',
    '기술이나 개념의 실현 가능성을 직접 검증해 보는 단계를 생각해 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    1
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '기사의 "상용화가 확대되고 있다"에서 ''상용화(商用化)''와 뜻이 가장 가까운 표현은 무엇인가요?',
    'multiple_choice',
    '["일상적인 상품으로 만들어 시중에 판매함", "학술적인 연구 목적으로 무료 배포함", "정부의 허가를 받아 비공개로 보관함", "해외로 기술을 전량 무상 이전함"]'::json,
    '일상적인 상품으로 만들어 시중에 판매함',
    '상용화는 연구·개발한 기술을 실제 상품으로 만들어 시장에서 유상으로 거래되게 하는 것을 의미합니다.',
    '기술을 상품으로 만들어 시장에서 판매할 수 있게 만드는 것입니다.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    1
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '애니브릿지의 박종세 대표는 한국과학기술원(KAIST) 전산학부 교수를 겸임하고 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '3문단에 "한국과학기술원(KAIST) 전산학부 교수인 박종세 대표를 중심으로"라고 명시되어 있으므로 O입니다.',
    '애니브릿지 박종세 대표의 이력을 3문단에서 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '퓨리오사AI가 개발한 2세대 AI 추론 가속기 제품의 이름은 무엇인가요?',
    'multiple_choice',
    '["RNGD(레니게이드)", "A100", "H100", "Gaudi3"]'::json,
    'RNGD(레니게이드)',
    '2문단에서 "퓨리오사AI의 2세대 AI 추론 가속기 ''RNGD(레니게이드)''"라고 명시되어 있습니다.',
    '퓨리오사AI의 2세대 추론 가속기 명칭을 기사 전반부에서 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    1
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '퓨리오사AI의 RNGD 가속기가 고성능·고효율 AI 추론을 지원하기 위해 기반으로 삼은 독자적인 아키텍처의 영문 약자(3글자)는 무엇인가요?',
    'short_answer',
    '[]'::json,
    'TCP',
    '4문단에 "독자적인 TCP(Tensor Contraction Processor) 아키텍처를 기반으로"라고 명시되어 있습니다.',
    '4문단에서 괄호 안의 영문 3글자 약자를 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '이 기사의 핵심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["애니브릿지와 퓨리오사AI의 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 공동 개발 협력", "글로벌 GPU 제조사들의 가격 인상에 따른 국내 스타트업의 대응책", "국내 대학 연구진의 생성형 AI 기반 무인 자율주행 알고리즘 개발 소식", "국가 차원의 데이터센터 전력 소비 절감 규제안 발표"]'::json,
    '애니브릿지와 퓨리오사AI의 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 공동 개발 협력',
    '기사는 AI 인프라 스타트업 애니브릿지와 NPU 기업 퓨리오사AI가 손잡고 NPU 기반의 기업용 AI 에이전트 플랫폼을 공동 개발·고도화한다는 내용을 핵심으로 다룹니다.',
    '두 기업의 협력 내용과 개발 대상인 플랫폼에 초점을 맞추세요.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    1
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '양사가 이번 협력을 통해 기업용 AI 에이전트 도입 장벽을 낮추고자 선택한 핵심 방식은 무엇인가요?',
    'multiple_choice',
    '["하드웨어와 소프트웨어의 동시 최적화", "해외 대기업 가속기 무료 배포", "클라우드 서비스 이용료의 대폭 인하", "기존 데이터센터의 전면 철거 및 신축"]'::json,
    '하드웨어와 소프트웨어의 동시 최적화',
    '2문단 부제목 및 6문단에서 "하드웨어와 소프트웨어를 함께 최적화하는 방식으로 기업용 AI 에이전트 도입 장벽을 낮춘다"고 설명합니다.',
    '하드웨어(NPU)와 소프트웨어(런타임)를 함께 어떻게 조율하는지 생각해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    1
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '최근 기업들이 생성형 AI를 도입할 때 단순 모델 성능뿐만 아니라 인프라 운영 비용과 안정성도 주요 요인으로 고려하고 있다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '6문단에서 "기업은 모델 성능뿐 아니라 인프라 비용과 안정적인 운영까지 함께 고려해야 하는 국면으로 접어들고 있다"라고 언급되어 있으므로 O입니다.',
    '6문단의 생성형 AI 서비스 활용 변화 양상을 참고하세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    1
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '다음 빈칸에 들어갈 가장 적절한 단어는 무엇인가요?
"애니브릿지는 특정 하드웨어에 대한 (                      )을/를 낮춘 공통 인터페이스를 통해 기업이 생성형 AI 서비스를 보다 효율적이고 안정적으로 운영하도록 돕는다."',
    'multiple_choice',
    '["종속성", "독립성", "호환성", "보안성"]'::json,
    '종속성',
    '3문단에서 "특정 하드웨어에 대한 종속성을 낮춘 공통 인터페이스와 워크로드 기반 최적화를 통해"라고 기술되어 있습니다.',
    '특정 하드웨어에 얽매이지 않도록 줄여주는 성질을 나타내는 단어입니다.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    1
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '기사의 전체 내용 흐름을 순서대로 바르게 요약한 것은 무엇인가요?',
    'multiple_choice',
    '["애니브릿지-퓨리오사AI 협약 체결 -> 양사의 주요 역량 및 기술 소개 -> 협력의 핵심 범위 및 기대 효과 -> 박종세 대표의 소감", "박종세 대표의 소감 -> 애니브릿지 회사의 단독 발표 -> 퓨리오사AI의 기술 인수 -> 해외 사업 진출 계획", "NPU 시장의 몰락 -> 양사의 협약 파기 소식 -> 퓨리오사AI 기술 소개 -> AI 서비스의 비용 증가 문제", "생성형 AI의 한계점 지적 -> NPU 개발 취소 -> 하드웨어 무상 지원 공고 -> 고객 PoC 실패 사례"]'::json,
    '애니브릿지-퓨리오사AI 협약 체결 -> 양사의 주요 역량 및 기술 소개 -> 협력의 핵심 범위 및 기대 효과 -> 박종세 대표의 소감',
    '기사는 협약 소식을 먼저 알리고, 각 사의 기술(애니브릿지/RNGD)과 구체적 협력 내용, 도입 효과를 설명한 뒤 대표의 한마디로 마무리됩니다.',
    '기사의 단락별 순서를 차례대로 점검해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    1
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] 애니브릿지는 GPU, NPU, PIM 등 다양한 AI 가속기를 서비스 특성에 맞춰 활용할 수 있도록 멀티 가속기 LLM 서빙 런타임과 기업용 AI 에이전트 플랫폼을 개발하는 AI 스타트업이다.

[문제] 위 문단에서 ''런타임(Runtime)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["프로그램이 실제로 실행되고 동작하는 시간이나 환경", "컴퓨터 부품을 제조하는 데 걸리는 공정 시간", "신제품 출시 전 사전 예약 신청을 받는 사이트", "데이터베이스를 백업하는 데 소요되는 점검 시간"]'::json,
    '프로그램이 실제로 실행되고 동작하는 시간이나 환경',
    '런타임(Runtime)은 컴퓨터 과학에서 프로그램이 구동되어 실제 실행되는 구동 환경 또는 그 실행 시간 단계를 의미합니다.',
    '프로그램이 켜져서 동작하는 실행 환경을 떠올려 보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    1
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] 양사는 기술 연동에 그치지 않고 실제 고객 환경에서 성능과 비용 효율을 검증하고 공동 레퍼런스를 확보하는 데까지 협력을 확대할 계획이다.

[문제] 위 문단의 ''레퍼런스(Reference)''는 시장이나 고객에게 기술력을 입증할 수 있는 ''실제 적용/참조 사례''라는 뜻으로 문맥상 적절하게 쓰였습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''레퍼런스''는 IT 업계에서 고객 구축 및 성공 사례(참조 모델)를 뜻하는 말로 문맥에 적절히 쓰였습니다.',
    '실제 고객사에 적용해 거둔 성공적인 구축 사례나 참조 모델을 뜻합니다.',
    'room',
    'vocab',
    'vocab_appropriateness',
    1
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] 애니브릿지와 퓨리오사AI의 협력 범위에는 클라우드 기반 서비스 개발과 실증, 고객 적용 및 PoC 등이 포함됩니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '5문단에서 "협력 범위에는 ... 클라우드 기반 서비스 개발과 실증, 고객 적용 및 PoC, 공동 레퍼런스와 사업화 기회 발굴 등이 포함된다"라고 제시되어 있습니다.',
    '5문단의 협력 범위 내용을 살펴보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    1
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] 퓨리오사AI는 RNGD 활용과 최적화를 위한 기술 정보와 개발 환경, 기술 지원을 제공하고, 애니브릿지는 이를 기반으로 AI 에이전트 워크로드에 최적화된 ____와 응용 솔루션을 개발·고도화한다.

[문제] 위 빈칸에 들어갈 3음절(한글) 용어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '런타임',
    '7문단에서 "애니브릿지는 이를 기반으로 AI 에이전트 워크로드에 최적화된 런타임과 응용 솔루션을 개발·고도화한다"라고 기술되어 있습니다.',
    '프로그램 실행 환경을 뜻하는 3글자 단어입니다.',
    'room',
    'info_extraction',
    'info_evidence',
    1
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] 애니브릿지는 GPU, NPU, PIM 등 다양한 AI 가속기를 서비스 특성에 맞춰 활용할 수 있도록 멀티 가속기 LLM 서빙 런타임과 기업용 AI 에이전트 플랫폼을 개발하는 AI 스타트업이다.

[문제] 위 문단에서 설명하는 애니브릿지의 핵심 사업 및 개발 영역은 무엇인가요?',
    'multiple_choice',
    '["멀티 가속기 지원 서빙 런타임 및 기업용 AI 에이전트 플랫폼 개발", "독자적 반도체 공장 설립을 통한 NPU 하드웨어 직접 양산", "스마트폰용 소셜 네트워크 서비스 앱 개발 및 운영", "클라우드 데이터센터의 물리적 전기 설비 유지 보수"]'::json,
    '멀티 가속기 지원 서빙 런타임 및 기업용 AI 에이전트 플랫폼 개발',
    '문단은 애니브릿지가 다양한 가속기를 지원하는 서빙 런타임과 기업용 AI 에이전트 플랫폼을 개발하는 AI 인프라 스타트업임을 명확히 서술합니다.',
    '애니브릿지가 무엇을 개발하는 스타트업인지 파악하세요.',
    'room',
    'core_understanding',
    'core_topic',
    1
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] 퓨리오사AI의 RNGD는 대규모 언어모델과 에이전틱 AI를 위한 데이터센터용 AI 추론 가속기로, 독자적인 TCP 아키텍처를 기반으로 고성능·고효율 AI 추론을 지원한다.

[문제] 위 문단에 가장 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["데이터센터용 AI 추론 가속기 ''RNGD''의 주요 특징", "TCP 아키텍처의 한계와 개발 중단 소식", "국내 모바일 반도체 시장의 매출 분석", "글로벌 데이터센터 파산에 따른 NPU 공급 차질"]'::json,
    '데이터센터용 AI 추론 가속기 ''RNGD''의 주요 특징',
    '문단은 퓨리오사AI의 RNGD 가속기가 대규모 언어모델/에이전틱 AI를 지원하며 독자적 TCP 아키텍처 기반이라는 특징을 다룹니다.',
    'RNGD 가속기의 기능과 아키텍처 특징이 담긴 소제목을 고르세요.',
    'room',
    'core_understanding',
    'core_title',
    1
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] 양사는 기술 연동에 그치지 않고 실제 고객 환경에서 성능과 ____ 효율을 검증하고 공동 레퍼런스를 확보하는 데까지 협력을 확대할 계획이다.

[문제] 빈칸에 들어갈 두 글자 단어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '비용',
    '기사 7문단에 "성능과 비용 효율을 검증하고"라는 문구가 제시되어 있습니다.',
    '성능과 함께 기업이 인프라 운용 시 중요하게 고려하는 요소입니다.',
    'room',
    'inference_judgment',
    'inference_blank',
    1
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] 생성형 AI의 활용 범위가 단순 질의응답을 넘어 코딩, 지식검색, 업무 자동화 등 에이전트형 서비스로 확대되면서 기업은 모델 성능뿐 아니라 인프라 비용과 안정적인 운영까지 함께 고려해야 하는 국면으로 접어들고 있다.

[문제] 위 문단을 통해 추론할 수 있는 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["AI 에이전트 서비스가 복잡해질수록 인프라의 효율적인 운영과 비용 절감이 기업 경쟁력의 핵심이 된다.", "질의응답 위주의 단순 AI 서비스는 인프라 비용이 훨씬 많이 소요된다.", "기업들은 코딩이나 지식검색 분야에서 생성형 AI의 활용을 전면 중단할 것이다.", "AI 모델 성능만 뛰어나면 인프라 비용이 아무리 높아도 기업 도입에 아무런 장애가 되지 않는다."]'::json,
    'AI 에이전트 서비스가 복잡해질수록 인프라의 효율적인 운영과 비용 절감이 기업 경쟁력의 핵심이 된다.',
    '서비스가 정교해지면서 단순 모델 성능을 넘어 실제 운영 인프라의 가성비와 안정성이 기업의 주된 고민거리가 되었음을 추론할 수 있습니다.',
    '서비스 고도화에 따른 기업의 인프라 관련 고민 변화를 떠올려 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    1
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] (A) 퓨리오사AI는 RNGD 기술 정보와 개발 환경을 제공하고, 애니브릿지는 최적화된 런타임을 개발한다.
(B) 애니브릿지와 퓨리오사AI가 NPU 기반 AI 에이전트 플랫폼 공동 개발 협약을 체결했다.
(C) 이를 통해 실제 고객 환경에서 성능과 비용 효율을 검증하고 공동 레퍼런스를 구축할 계획이다.

[문제] 논리적 연결 순서로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["(B) -> (A) -> (C)", "(A) -> (B) -> (C)", "(C) -> (B) -> (A)", "(B) -> (C) -> (A)"]'::json,
    '(B) -> (A) -> (C)',
    '협약 체결(B) -> 각사의 역할 분담 및 기술 제공(A) -> 검증 및 레퍼런스 확보라는 목표 달성(C) 순서로 구성하는 것이 자연스럽습니다.',
    '협력 발표, 역할 분담, 최종 목표로 이어지는 흐름을 파악하세요.',
    'room',
    'structure',
    'structure_order',
    1
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '애니브릿지, 퓨리오사AI와 함께 NPU 기반 엔터프라이즈 AI 에이전트 플랫폼 개발 착수'),
    '[문단] 퓨리오사AI는 RNGD 활용과 최적화를 위한 기술 정보를 제공한다. [ ㄱ ] 애니브릿지는 이를 기반으로 AI 에이전트에 최적화된 런타임을 고도화한다.

[문제] [ ㄱ ] 위치에 들어갈 문맥상 가장 적절한 접속어는 무엇인가요?',
    'multiple_choice',
    '["한편", "하지만", "왜냐하면", "마침내"]'::json,
    '한편',
    '퓨리오사AI의 역할 제공에 이어 상응하는 애니브릿지의 역할을 연달아 설명하고 있으므로 대등/연결 접속어 ''한편''이 들어가는 것이 적절합니다.',
    '한쪽의 역할에 대응하는 상대방의 역할을 이어주는 단어를 찾으세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    1
);

-- 기사(''카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'')는 이미 DB에 있음(V12/V15).
-- 여기서는 그 기사에 문제 20개만 추가한다. news_id는 제목으로 조회한다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '기사에 등장한 ''고용승계(雇用承繼)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["회사나 사업이 변경될 때 기존 근로자의 노동계약과 신분을 그대로 이어받는 것", "신규 채용을 통해 새로운 인재를 대규모로 뽑는 것", "근로자의 퇴직금을 조기 정산하여 지급하는 것", "임원을 외부에서 스카우트하여 새로 임명하는 것"]'::json,
    '회사나 사업이 변경될 때 기존 근로자의 노동계약과 신분을 그대로 이어받는 것',
    '고용승계는 기업의 분할, 합병, 양도 등이 일어날 때 기존 근로자의 고용 관계 및 노동 조건을 새로운 법인이 이어받아 계속 유지하는 것을 뜻합니다.',
    '기존에 일하던 근로자의 일자리와 계약을 이어받는 것을 뜻합니다.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    1
),
-- 2. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '기사의 "절차에 제동을 걸겠다는 방침이다"에서 ''제동(制動)''과 뜻이 가장 가까운 단어는 무엇인가요?',
    'multiple_choice',
    '["저지", "촉진", "승인", "지원"]'::json,
    '저지',
    '''제동을 걸다''는 어떤 일의 진행을 막거나 멈추게 한다는 뜻으로 ''저지''와 뜻이 가장 통합니다.',
    '진행되던 일을 막거나 멈추게 하는 행위를 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_paraphrase',
    1
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '상법상 발행주식총수의 20% 이상 주주가 반대 의사를 통지하면 주주총회를 거치지 않는 소규모합병 방식으로 진행할 수 없습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '6문단에 "상법상 발행주식총수의 20% 이상 주주가 반대 의사를 통지하면 주주총회를 거치지 않는 소규모합병 방식으로 진행할 수 없다"라고 분명히 서술되어 있습니다.',
    '기사의 소규모합병 제동 관련 문단을 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '카카오가 인적분할을 통해 나누겠다고 발표한 두 법인의 명칭으로 올바른 조합은 무엇인가요?',
    'multiple_choice',
    '["카카오X - 카카오AI", "카카오Pay - 카카오Bank", "카카오Mobility - 카카오Games", "카카오Enterprise - 카카오Brain"]'::json,
    '카카오X - 카카오AI',
    '3문단에서 "투자·포트폴리오 관리를 맡는 ''카카오X''와 인공지능(AI) 기술 기반 서비스를 담당하는 ''카카오AI''로 회사를 나누는 인적분할 계획"이라고 언급되어 있습니다.',
    '카카오가 투자를 담당할 회사와 AI를 담당할 회사로 나눈 명칭을 찾으세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    1
),
-- 5. info_extraction / info_consistency (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '노조가 사측에 제시한 요구사항은 총 몇 가지인가요? (숫자만 작성)',
    'short_answer',
    '[]'::json,
    '5',
    '8문단에서 "노조는 사측에 △분할 필요성 설명 △고용·노동조건 서면 보장 △인력 배치 기준 공개 △조직개편·매각 시 노조 사전협의 △분할가치 정보 공개 등 5가지를 요구했다"라고 밝혔습니다.',
    '기사 하단부에서 노조의 요구사항 개수를 확인하세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    1
),
-- 6. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '이 기사의 핵심 주제로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["카카오 노조의 인적분할 반대 성명 및 고용·주주가치 보장을 위한 소규모합병 저지 행보", "카카오의 신규 AI 서비스 출시 및 해외 시장 진출 전략 발표", "카카오 노사의 임금 인상 합의 체결 및 상생 협약식 개최", "국내 IT 기업들의 자회사 상장 규제 완화 요구 서명 운동"]'::json,
    '카카오 노조의 인적분할 반대 성명 및 고용·주주가치 보장을 위한 소규모합병 저지 행보',
    '기사는 카카오 노조가 고용안정과 주주가치 보호 대책이 부족하다는 이유로 인적분할에 반대하며 소규모합병을 저지하려는 상황을 종합적으로 다루고 있습니다.',
    '카카오 노조가 인적분할에 반대하며 내세운 주장과 대응책이 전체 핵심입니다.',
    'daily_solo',
    'core_understanding',
    'core_topic',
    1
),
-- 7. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '카카오 노조가 고용승계와 관련하여 사측에 강력히 요구하는 핵심 조건은 무엇인가요?',
    'multiple_choice',
    '["단순 구두 선언에 그치지 않고 구체적인 대책을 서면으로 보장하는 것", "전 임직원의 임금을 조건 없이 20% 인상하는 것", "분할 후 모든 직원을 신설 회사로 강제 이직시키는 것", "해외 법인 발령을 완전히 금지하는 조항을 신설하는 것"]'::json,
    '단순 구두 선언에 그치지 않고 구체적인 대책을 서면으로 보장하는 것',
    '노조는 원칙적인 선언만으로는 부족하며, 임금·복지·근속 유지 및 배치 기준 등을 명확한 서면으로 보장해야 한다고 주장합니다.',
    '고용승계 소제목 바로 아래 문단 내용을 참고하세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    1
),
-- 8. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '카카오 노조는 회사의 경영권 자체를 완전히 부정하고 반대하기 위해 이번 소규모합병 반대 운동을 전개하는 것이다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '마지막 문단에서 서승욱 지회장은 "경영권 자체를 부정하는 것이 아니라 노동자의 권리와 주주 가치가 지켜져야 한다는 취지"라고 분명히 밝혔으므로 X입니다.',
    '기사의 마지막 문단 지회장의 발언을 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    1
),
-- 9. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '다음 빈칸에 들어갈 가장 적절한 단어는 무엇인가요?
"노조는 카카오인베스트먼트 흡수합병 시 주주총회를 거치지 않는 소규모합병을 막기 위해, 발행주식총수의 20% 이상에 해당하는 반대 의사를 확보하여 사측의 (                      ) 방식 절차를 저지하려 한다."',
    'multiple_choice',
    '["주주총회 면제", "법원 강제집행", "정부 인가", "노사 공동의결"]'::json,
    '주주총회 면제',
    '소규모합병은 원래 주주총회 승인을 거치지 않는 방식인데, 20% 이상 주주가 반대하면 이처럼 주주총회가 면제되는 간이 방식 진행이 불가능해집니다.',
    '소규모합병이 주주총회를 건너뛰는 절차라는 점을 떠올려 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_blank',
    1
),
-- 10. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '기사의 전체 내용 흐름을 순서대로 바르게 요약한 것은 무엇인가요?',
    'multiple_choice',
    '["노조의 인적분할 반대 입장 -> 고용 및 주주가치 우려 사항 -> 소규모합병 저지 목표 및 5대 요구사항", "소규모합병 성공 발표 -> 노조의 5대 요구사항 -> 경영권 부정 성명", "인적분할 완료 소식 -> 노조 조합원 탈퇴 운동 -> 일반 주주 대상 이익 배당 요청", "노사 합의 타결 -> 카카오X 설립 승인 -> 소액주주들과의 연대 철회"]'::json,
    '노조의 인적분할 반대 입장 -> 고용 및 주주가치 우려 사항 -> 소규모합병 저지 목표 및 5대 요구사항',
    '기사는 노조의 인적분할 반대 선언을 시작으로 고용안정 및 주주가치 우려를 상술한 뒤, 소규모합병 저지 전략과 5대 요구사항으로 마무리됩니다.',
    '기사의 소제목 흐름과 단락 구조를 확인해 보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    1
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] 노조는 특히 고용승계 원칙 선언에 그치지 않고 구체적인 대책이 서면으로 보장돼야 한다고 주장했다.

[문제] 위 문단에서 ''서면(書面)''의 의미로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["글로 작성한 문서나 서류", "말이나 구두로 주고받는 약속", "온라인 영상 통화 내용", "전자 기기에 저장된 음성 파일"]'::json,
    '글로 작성한 문서나 서류',
    '서면은 구두(말)가 아닌, 일정한 내용을 글이나 문서로 적어서 남기는 서류를 의미합니다.',
    '말로만 하는 약속과 달리 문서로 증거를 남기는 형태입니다.',
    'room',
    'vocab',
    'vocab_meaning',
    1
),
-- 12. vocab / vocab_appropriateness (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] 주식을 비례 배정받더라도 향후 추가 상장, 증자, 계열사 간 거래에 따른 가치 하락 위험이 있는 만큼...

[문제] 위 문단의 ''증자(增資)''는 ''기업이 자본금을 늘리기 위해 주식을 새로 발행하는 것''이라는 의미로 적절하게 쓰였습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '''증자''는 한자 뜻 그대로 자본금을 늘리는 일이며, 신주 발행을 통해 주식 수가 늘어 기존 주주의 가치 희석이 일어날 수 있는 행위입니다.',
    '자본금을 더 늘리기 위해 주식을 발행하는 경제 용어입니다.',
    'room',
    'vocab',
    'vocab_appropriateness',
    1
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] 반대 의사표시 대상은 지난 7일 기준 주주명부에 등재된 주주로, 실질주주는 거래 증권사를 통해 의사를 제출할 수 있습니다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '7문단 첫 문장에 "반대 의사표시 대상은 지난 7일 기준 주주명부에 등재된 주주로, 실질주주는 거래 증권사를 통해 의사를 제출할 수 있다"라고 적혀 있으므로 O입니다.',
    '7문단의 반대 의사표시 대상 및 제출 방법을 확인해 보세요.',
    'room',
    'info_extraction',
    'info_consistency',
    1
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] 노조는 우선 내년 1월 1일 합병기일을 목표로 진행 중인 카카오인베스트먼트 흡수합병 절차에 제동을 걸겠다는 방침이다.

[문제] 카카오가 카카오인베스트먼트와의 흡수합병을 목표로 설정한 합병기일은 내년 몇 월 몇 일인가요? (예: 3월 15일)',
    'short_answer',
    '[]'::json,
    '1월 1일',
    '문단에서 "내년 1월 1일 합병기일을 목표로 진행 중인"이라고 명시되어 있습니다.',
    '합병기일로 언급된 월과 일을 찾아 쓰세요.',
    'room',
    'info_extraction',
    'info_evidence',
    1
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] 주식을 비례 배정받더라도 향후 추가 상장, 증자, 계열사 간 거래에 따른 가치 하락 위험이 있는 만큼, 분할가치 산정 근거와 후속 사업재편 방향을 일반 주주에게 투명하게 공개해야 한다는 입장이다.

[문제] 위 문단에서 노조가 지적하는 주주 측면의 핵심 문제는 무엇인가요?',
    'multiple_choice',
    '["인적분할 및 후속 재편 과정에서 발생할 수 있는 주주가치 훼손 위험", "주주들에 대한 분기 배당금 지급 지연 우려", "외국인 주주들의 주식 매도로 인한 환율 변동성", "소액주주들의 의결권 행사 완전 박탈"]'::json,
    '인적분할 및 후속 재편 과정에서 발생할 수 있는 주주가치 훼손 위험',
    '문단은 추가 상장이나 증자 등으로 기존 주주의 주식 가치가 하락할 위험이 있으므로 투명한 정보 공개가 필요하다는 점을 강조합니다.',
    '주식 가치 하락 및 투명성 부족 문제를 파악해 보세요.',
    'room',
    'core_understanding',
    'core_topic',
    1
),
-- 16. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] 노조는 우선 내년 1월 1일 합병기일을 목표로 진행 중인 카카오인베스트먼트 흡수합병 절차에 제동을 걸겠다는 방침이다. 상법상 발행주식총수의 20% 이상 주주가 반대 의사를 통지하면 주주총회를 거치지 않는 소규모합병 방식으로 진행할 수 없다.

[문제] 위 문단에 가장 어울리는 소제목은 무엇인가요?',
    'multiple_choice',
    '["20% 반대표 확보로 소규모합병 저지 추진", "카카오인베스트먼트의 주식 전량 매각 결정", "주주총회 무산에 따른 전격적 합병 승인", "노사 공동 합병 추진위원회 공식 발족"]'::json,
    '20% 반대표 확보로 소규모합병 저지 추진',
    '문단은 20% 이상의 반대 표를 확보하여 주주총회 없이 진행되는 소규모합병을 막겠다는 노조의 구체적 대응 방안을 다루고 있습니다.',
    '소규모합병을 막기 위한 20% 반대 조건에 초점을 맞춰 제목을 찾으세요.',
    'room',
    'core_understanding',
    'core_title',
    1
),
-- 17. inference_judgment / inference_blank (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] 서승욱 카카오지회장은 "경영권 자체를 부정하는 것이 아니라 노동자의 권리와 ____가 지켜져야 한다는 취지"라고 밝혔다.

[문제] 맥락상 빈칸에 들어갈 네 글자 용어는 무엇인가요?',
    'short_answer',
    '[]'::json,
    '주주가치',
    '기사 마지막 문단에서 "노동자의 권리와 주주 가치가 지켜져야 한다는 취지"라고 서승욱 지회장이 언급했습니다.',
    '노동자의 권리와 함께 지켜져야 할 주주의 권익을 뜻하는 말입니다.',
    'room',
    'inference_judgment',
    'inference_blank',
    1
),
-- 18. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] 노조는 조합원과 소액주주들에게 반대 의사표시 동참을 요청하고, 사측 대응에 따라 소액주주들과의 연대 및 공동 대응도 검토하기로 했다.

[문제] 위 문단을 통해 알 수 있는 카카오 노조의 전략으로 올바른 것은 무엇인가요?',
    'multiple_choice',
    '["소액주주들과의 연대를 확대하여 20% 반대 지분을 효율적으로 확보하려 한다.", "조합원만의 힘으로 충분하므로 외부 주주들과의 소통을 차단하려 한다.", "사측의 제안을 조건 없이 수용하여 소액주주들의 요구를 무시하려 한다.", "법적 대응을 완전히 포기하고 사측의 자발적 철회만을 기다리려 한다."]'::json,
    '소액주주들과의 연대를 확대하여 20% 반대 지분을 효율적으로 확보하려 한다.',
    '노조 지부 지분만으로는 20% 목표 달성이 어려울 수 있으므로, 소액주주들과 연대하여 함께 반대 의사를 모으는 전략을 취하고 있습니다.',
    '노조가 소액주주들에게 동참을 요청하는 이유를 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    1
),
-- 19. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] (A) 카카오 노조가 사측의 인적분할 계획에 반대 입장을 발표했다.
(B) 고용 불안과 주주가치 훼손 위험을 지적하며 5가지 요구사항을 제시했다.
(C) 인적분할의 첫 단계인 소규모합병을 막기 위해 20% 반대 의사 확보에 나섰다.

[문제] 논리적 흐름에 맞춘 가장 적절한 순서는 무엇인가요?',
    'multiple_choice',
    '["(A) -> (B) -> (C)", "(B) -> (A) -> (C)", "(C) -> (B) -> (A)", "(A) -> (C) -> (B)"]'::json,
    '(A) -> (B) -> (C)',
    '인적분할 반대 입장 표명(A) -> 세부 지적 이유 및 5대 요구사항 제시(B) -> 소규모합병 저지를 위한 반대 표 확보 실동(C) 순서로 논리가 전개됩니다.',
    '문제 제기에서 세부 이유 설명, 그리고 실제 실동 수단으로 이어지는 흐름입니다.',
    'room',
    'structure',
    'structure_order',
    1
),
-- 20. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '카카오 노조 "고용·주주가치 설명 없인 못 받아들여"'),
    '[문단] 카카오는 회사를 나누는 인적분할 계획을 발표했다. [ ㄱ ] 노조는 현시점 분할의 필요성과 위험 부담 주체 등에 대한 설명이 부족하다며 반대 성명을 냈다.

[문제] [ ㄱ ] 위치에 들어갈 가장 적절한 접속어는 무엇인가요?',
    'multiple_choice',
    '["그러나", "따라서", "왜냐하면", "예를 들어"]'::json,
    '그러나',
    '사측의 인적분할 발표와 이에 상충되는 노조의 반대 입장을 연결하므로 역접의 접속어 ''그러나''가 적절합니다.',
    '사측의 계획 발표와 노조의 반대 반응 사이를 잇는 말을 찾으세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    1
);

-- 기사(''오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'')는 이미 DB에 있음(V12/V15, 저장된 level은 1).
-- 문제 난이도는 사용자 확인에 따라 4로 넣는다. daily 3번(OX)은 원본에 content가 누락돼 있어
-- explanation 근거(IaaS 매출 121%/74억 달러)에 맞춰 오답 문장으로 새로 작성했다.

-- [dailyQuestions 1~10] (game_mode: 'daily_solo')
INSERT INTO questions (
    news_id, content, question_format, choices, answer, explanation, hint, game_mode, main_category, sub_category, level
) VALUES
-- 1. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '다음 문장에 나오는 ''인프라''의 의미로 가장 적절한 것은 무엇인가요?

"오라클은 AI 학습·추론 수요를 선점하기 위해 데이터센터와 그래픽처리장치(GPU) 등 인프라 투자를 확대하고 있다."',
    'multiple_choice',
    '["어떤 활동이나 사업의 기반이 되는 생산 시설이나 제도", "소프트웨어를 개발할 때 사용하는 프로그래밍 언어", "인공지능 모델이 스스로 학습할 때 사용하는 데이터셋", "기업이 제품을 판매할 때 사용하는 마케팅 전략"]'::json,
    '어떤 활동이나 사업의 기반이 되는 생산 시설이나 제도',
    '인프라(인프라스트럭처)는 데이터센터나 네트워크처럼 특정 서비스나 산업을 운영하는 데 필요한 기초 시설과 시스템을 뜻합니다.',
    '데이터센터나 서버처럼 AI 서비스를 운영하기 위해 필요한 기본 바탕을 떠올려 보세요.',
    'daily_solo',
    'vocab',
    'vocab_meaning',
    4
),
-- 2. vocab / vocab_appropriateness (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '다음 문장의 ''견인''과 뜻이 통하여 바꾸어 쓰기에 가장 적절한 단어는 무엇인가요?

"이번 실적의 성장축을 견인한 것은 클라우드 인프라 사업이었다."',
    'multiple_choice',
    '["방해", "주도", "감소", "포기"]'::json,
    '주도',
    '''견인''은 끌어당겨 이끈다는 뜻이므로, 성장을 이끌어 나갔다는 의미의 ''주도''로 바꾸어 쓰는 것이 가장 적절합니다.',
    '''견인차 역할''이라는 말처럼 성장을 앞장서서 끌고 갔다는 뜻의 단어를 찾아보세요.',
    'daily_solo',
    'vocab',
    'vocab_appropriateness',
    4
),
-- 3. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '오라클의 서비스형 인프라(IaaS) 매출은 전년 동기 대비 62% 증가한 116억 달러를 기록했습니다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '기사에 따르면 오라클의 2027회계연도 1분기 IaaS 매출은 전년 동기 대비 121% 증가한 74억 달러를 기록했습니다. 62% 증가한 116억 달러는 SaaS를 포함한 전체 클라우드 매출입니다.',
    '기사 중반부의 OCI 및 IaaS 매출 증가율 수치를 확인해 보세요.',
    'daily_solo',
    'info_extraction',
    'info_consistency',
    4
),
-- 4. info_extraction / info_evidence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '오라클의 잉여현금흐름(FCF)이 53억 9600만 달러 적자를 기록한 직접적인 원인으로 지목된 항목은 무엇인가요?',
    'multiple_choice',
    '["소프트웨어 지원 매출의 급격한 상승", "데이터센터 및 서버, GPU 확충을 위한 대규모 자본지출", "환율 변동으로 인한 해외 사업 손실", "넷스위트 서비스의 마케팅 비용 과다 집행"]'::json,
    '데이터센터 및 서버, GPU 확충을 위한 대규모 자본지출',
    '기사에서는 데이터센터, 서버, GPU 등 AI 클라우드 인프라 확충을 위한 자본지출이 285억 달러로 늘면서 잉여현금흐름이 적자를 기록했다고 설명합니다.',
    '자본지출 항목과 잉여현금흐름 적자 원인이 언급된 문단을 찾아보세요.',
    'daily_solo',
    'info_extraction',
    'info_evidence',
    4
),
-- 5. core_understanding / core_title (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '이 기사의 내용을 종합하여 가장 어울리는 제목을 고르시오.',
    'multiple_choice',
    '["오라클, SW 매출 급감으로 클라우드 사업 전면 철수 선언", "AI 클라우드 고성장에 장외 주가 상승…대규모 인프라 투자 지속", "온프레미스 시장의 완전한 부활과 빅테크 기업들의 투자 축소", "글로벌 GPU 가격 하락으로 인한 AI 데이터센터 건설 중단"]'::json,
    'AI 클라우드 고성장에 장외 주가 상승…대규모 인프라 투자 지속',
    '기사는 오라클이 AI 클라우드 인프라의 세 자릿수 성장에 힘입어 장외 주가가 반등했으나, 대규모 자본지출에 대한 시장의 관심도 함께 존재한다는 내용을 다루고 있습니다.',
    'AI 클라우드의 높은 성장세와 이에 따른 투자/주가 반응을 종합한 제목을 골라보세요.',
    'daily_solo',
    'core_understanding',
    'core_title',
    4
),
-- 6. core_understanding / core_gist (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '이 기사가 전달하려는 핵심 내용으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["오라클은 대규모 자본지출 부담에도 불구하고 AI 클라우드 인프라의 높은 성장에 힘입어 시장의 기대를 받고 있다.", "오라클은 소프트웨어 라이선스 매출 감소를 극복하지 못하고 심각한 영업이익 감소를 겪고 있다.", "월가의 모든 애널리스트는 오라클의 잉여현금흐름 적자에 대해 매수 의견을 철회하고 매도를 권고했다.", "AI 클라우드 시장의 수요가 공급보다 적어져 오라클의 GPU 가동률이 급격히 낮아졌다."]'::json,
    '오라클은 대규모 자본지출 부담에도 불구하고 AI 클라우드 인프라의 높은 성장에 힘입어 시장의 기대를 받고 있다.',
    '기사는 대규모 투자로 인한 현금흐름 부담 우려에도 불구하고, AI 클라우드 수요 폭증과 매출 고성장이 오라클의 핵심 성장동력이 되고 있음을 보여줍니다.',
    '대규모 투자 우려와 클라우드 매출 고성장이라는 두 축을 바탕으로 전체 글의 요지를 파악해 보세요.',
    'daily_solo',
    'core_understanding',
    'core_gist',
    4
),
-- 7. inference_judgment / inference_implication (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '오라클의 기존 소프트웨어(SW) 매출이 감소한 것에 대해 회사가 밝힌 배경으로 추론할 수 있는 것은 무엇인가요?',
    'multiple_choice',
    '["고객들이 기존 온프레미스 환경에서 클라우드 환경으로 전환하고 있기 때문이다.", "오라클 소프트웨어의 품질이 크게 떨어져 고객들이 이용을 중단했기 때문이다.", "정부의 규제로 인해 소프트웨어 라이선스 판매가 금지되었기 때문이다.", "GPU 공급 부족으로 인해 소프트웨어 개발이 중단되었기 때문이다."]'::json,
    '고객들이 기존 온프레미스 환경에서 클라우드 환경으로 전환하고 있기 때문이다.',
    '오라클 측은 고객들이 전통적인 온프레미스 환경에서 클라우드로 이전함에 따라 소프트웨어 매출 감소가 나타났다고 설명했습니다.',
    '''클라우드 전환 영향에 SW 매출 감소'' 소제목 및 해당 문단을 확인해 보세요.',
    'daily_solo',
    'inference_judgment',
    'inference_implication',
    4
),
-- 8. inference_judgment / inference_continuation (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '월가 애널리스트들의 의견을 바탕으로 할 때, 향후 오라클 주가 흐름의 핵심 변수로 이어질 내용은 무엇인가요?',
    'multiple_choice',
    '["대규모 투자비가 얼마나 빠르게 매출 및 현금흐름 개선으로 이어지는지 여부", "스페이스X의 우주선 발사 성공 여부와 위성 통신 속도", "소프트웨어 지원 매출을 기존 온프레미스로 재분류하는 작업", "넷스위트 서비스의 명칭 변경 및 신규 로고 발표"]'::json,
    '대규모 투자비가 얼마나 빠르게 매출 및 현금흐름 개선으로 이어지는지 여부',
    '기사는 막대한 데이터센터 투자비가 향후 수익성과 현금흐름 개선으로 얼마나 빠르게 전환되는지, 그리고 RPO의 실제 매출 전환 속도가 향후 핵심 변수라고 언급합니다.',
    '기사 마지막 부분에서 월가의 신중론과 향후 과제로 언급된 부분을 확인하세요.',
    'daily_solo',
    'inference_judgment',
    'inference_continuation',
    4
),
-- 9. structure / structure_order (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '다음 기사의 주요 내용을 논리적 흐름에 맞게 나열한 것을 고르시오.

(가) OCI를 중심으로 한 1분기 클라우드 실적 발표 및 AI 인프라 확충 수치 공개
(나) 실적 발표 전 자본지출 부담에 따른 약세와 AI 클라우드 호조로 인한 시간외 주가 반등
(다) 투자 부담에 대한 월가의 상반된 평가와 현금흐름 개선에 대한 전망',
    'multiple_choice',
    '["(나) - (가) - (다)", "(가) - (나) - (다)", "(다) - (가) - (나)", "(나) - (다) - (가)"]'::json,
    '(나) - (가) - (다)',
    '기사는 전체 요약 및 주가 반응(나)을 먼저 제시한 뒤, 구체적인 1분기 클라우드 실적 수치(가)를 보여주고, 마지막으로 월가의 찬반 평가 및 향후 전망(다)으로 구성되어 있습니다.',
    '기사의 도입부, 중반부 실적 수치, 후반부 월가 평가의 순서를 살펴보세요.',
    'daily_solo',
    'structure',
    'structure_order',
    4
),
-- 10. structure / structure_irrelevant_sentence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '다음 글의 전체 흐름과 관계없는 문장을 고르시오.

"오라클은 AI 학습·추론 수요를 선점하기 위해 데이터센터와 그래픽처리장치(GPU) 등 인프라 투자를 확대하고 있다. (ㄱ) 데이터센터 건설이 본격화하면 고대역폭메모리(HBM)와 고성능 서버 등 공급망 전반의 수요가 늘어날 수 있다. (ㄴ) 최근 국내 이동통신사들은 알뜰폰 요금제 개편을 단행했다. (ㄷ) 오라클은 이번 분기에 데이터센터 용량 850메가와트(MW)를 추가 공급하며 인프라 확충에 집중했다."',
    'multiple_choice',
    '["(ㄱ)", "(ㄴ)", "(ㄷ)", "없음"]'::json,
    '(ㄴ)',
    '(ㄴ)은 알뜰폰 요금제 개편에 대한 내용으로, 오라클의 AI 데이터센터 인프라 투자를 설명하는 글 전체 문맥과 전혀 관계가 없습니다.',
    '오라클의 AI 데이터센터 인프라 투자와 관련이 없는 문장을 찾아보세요.',
    'daily_solo',
    'structure',
    'structure_irrelevant_sentence',
    4
),

-- [gameQuestions 1~10] (game_mode: 'room')
-- 11. vocab / vocab_meaning (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] 오라클은 AI 학습·추론 수요를 선점하기 위해 데이터센터와 그래픽처리장치(GPU) 등 인프라 투자를 확대하고 있다.

[문제] 위 문단에서 ''남보다 앞서서 얻거나 차지함''을 뜻하는 단어는 무엇인가요?',
    'multiple_choice',
    '["선점", "확대", "수요", "추론"]'::json,
    '선점',
    '''선점''은 남보다 먼저 차지한다는 뜻입니다.',
    '인프라 투자를 확대하여 수요를 남들보다 먼저 잡으려는 행동을 나타내는 단어를 찾아보세요.',
    'room',
    'vocab',
    'vocab_meaning',
    4
),
-- 12. vocab / vocab_paraphrase (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] 오라클은 10일(현지시간) 2027회계연도 1분기 매출이 전년 동기 대비 30% 증가한 193억 5000만 달러를 기록했다고 밝혔다.

[문제] 위 문단의 ''전년 동기 대비''를 쉬운 표현으로 바꾼 것으로 가장 적절한 것은 무엇인가요?',
    'multiple_choice',
    '["작년 같은 기간과 비교하여", "지난달과 비교하여", "내년 동일한 계절과 비교하여", "지난주 같은 요일에 비해"]'::json,
    '작년 같은 기간과 비교하여',
    '''전년 동기 대비''는 작년의 같은 기간과 비교했을 때라는 뜻입니다.',
    '''전년(작년)''과 ''동기(같은 기간)''라는 한자어의 의미를 생각해 보세요.',
    'room',
    'vocab',
    'vocab_paraphrase',
    4
),
-- 13. info_extraction / info_consistency (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] 일반회계기준(GAAP) 영업이익은 67억 달러로 57% 늘었고, 일회성 항목 등을 제외한 비일반회계기준(Non-GAAP) 영업이익은 82억 달러로 31% 증가했다.

[문제] 오라클의 1분기 비일반회계기준(Non-GAAP) 영업이익은 67억 달러이다. (O/X)',
    'OX',
    '[]'::json,
    'X',
    '문단에 따르면 비일반회계기준(Non-GAAP) 영업이익은 82억 달러이며, 67억 달러는 일반회계기준(GAAP) 영업이익입니다.',
    '문단에서 비일반회계기준 영업이익 옆에 적힌 금액을 정확히 확인하세요.',
    'room',
    'info_extraction',
    'info_consistency',
    4
),
-- 14. info_extraction / info_evidence (short_answer)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] 오라클은 이번 분기에 데이터센터 용량 850메가와트(MW)를 추가 공급하고, AI 클라우드 고객에게 GPU 30만 개 이상을 인도했다고 밝혔다.

[문제] 오라클이 이번 분기에 AI 클라우드 고객에게 인도한 GPU의 수량은 몇 개 이상인가요? (숫자와 단위 포함)',
    'short_answer',
    '[]'::json,
    '30만개',
    '문단에서 AI 클라우드 고객에게 GPU 30만 개 이상을 인도했다고 명시되어 있습니다.',
    '문단 후반부의 GPU 인도 수량을 확인하세요.',
    'room',
    'info_extraction',
    'info_evidence',
    4
),
-- 15. core_understanding / core_topic (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] 이번 실적의 중심은 오라클 클라우드 인프라스트럭처(OCI) 사업이었다. OCI를 포함한 서비스형 인프라(IaaS) 매출은 74억 달러로 121% 늘었고 서비스형 소프트웨어(SaaS)를 포함한 전체 클라우드 매출은 116억 달러로 62% 증가했다.

[문제] 위 문단이 주로 다루고 있는 중심 소재는 무엇인가요?',
    'multiple_choice',
    '["오라클의 클라우드 사업 실적 성장", "스마트폰 애플리케이션 다운로드 수", "전통적인 PC 소프트웨어의 판매 중단", "해외 공장 건설을 위한 부지 확보"]'::json,
    '오라클의 클라우드 사업 실적 성장',
    '문단은 OCI 및 IaaS, SaaS 등 오라클의 클라우드 사업 매출 성장에 대해 설명하고 있습니다.',
    'OCI, IaaS, 클라우드 매출 등 문단에서 반복되는 주요 핵심어를 살펴보세요.',
    'room',
    'core_understanding',
    'core_topic',
    4
),
-- 16. core_understanding / core_argument (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] 폴 믹스 프리덤캐피털마켓츠 애널리스트는 "오라클이 AI 확장 전략을 뒷받침하기 위해 잉여현금흐름 적자를 여러 분기째 이어가고 있어 우려된다"고 지적했다.

[문제] 폴 믹스 애널리스트의 주장으로 알맞은 것은 무엇인가요?',
    'multiple_choice',
    '["오라클의 지속적인 잉여현금흐름 적자에 대해 우려하고 있다.", "오라클의 AI 확장 전략이 너무 느려서 문제라고 생각한다.", "오라클이 데이터센터를 즉시 매각해야 한다고 주장한다.", "오라클의 주가가 너무 낮아 무조건 매수해야 한다고 본다."]'::json,
    '오라클의 지속적인 잉여현금흐름 적자에 대해 우려하고 있다.',
    '폴 믹스는 오라클이 AI 확장을 위해 잉여현금흐름 적자를 이어가는 것에 대해 우려를 표했습니다.',
    '애널리스트가 지적한 ''잉여현금흐름 적자''라는 키워드에 집중해 보세요.',
    'room',
    'core_understanding',
    'core_argument',
    4
),
-- 17. inference_judgment / inference_blank (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] 오라클은 "AI 클라우드 학습 및 추론 서비스에 대한 고객 수요가 계속해서 공급보다 빠르게 증가하고 있다"며 "이번 분기 300억 달러 이상의 AI 클라우드 계약을 새로 체결해 ____이 6640억 달러로 늘었다"고 실적발표에서 설명했다.

[문제] 문단의 빈칸에 들어갈 알맞은 용어는 무엇인가요?',
    'multiple_choice',
    '["잔여계약의무(RPO)", "단기 차입금", "주식 배당금", "연구 개발비"]'::json,
    '잔여계약의무(RPO)',
    '신규 계약 체결을 통해 6,640억 달러로 늘어났다고 설명한 항목은 잔여계약의무(RPO)입니다.',
    '새로 체결한 클라우드 계약의 결과로 누적된 수주 잔고를 뜻하는 용어를 찾아보세요.',
    'room',
    'inference_judgment',
    'inference_blank',
    4
),
-- 18. inference_judgment / inference_implication (OX)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] 1분기 GPU 가동률은 97.9%로 매우 높은 수준을 유지했고, GPU의 수명과 가치도 계속 우리를 놀라게 하고 있다.

[문제] GPU 가동률이 97.9%라는 것은 오라클의 GPU 보유 자원이 쉬지 않고 거의 전부 사용되고 있음을 의미한다. (O/X)',
    'OX',
    '[]'::json,
    'O',
    '가동률이 97.9%에 달한다는 것은 대부분의 GPU 장비가 고객의 AI 작업 처리에 쉴 새 없이 활용되고 있음을 뜻합니다.',
    '97.9%라는 높은 가동률 수치가 가진 의미를 생각해 보세요.',
    'room',
    'inference_judgment',
    'inference_implication',
    4
),
-- 19. structure / structure_sentence_insertion (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] 10일 정규장에서 152.94달러에 마감한 오라클 주가는 실적 발표 뒤 시간외 거래에서 한때 6.9% 상승한 163.50달러까지 올랐다. [ 1 ] 이후 159.26달러 선에서 거래됐다. [ 2 ] 다만 시간외 주가는 시시각각 변동하는 만큼 기준 시각을 함께 명시할 필요가 있다. [ 3 ]

[문제] "주가는 발표 직후 큰 폭으로 솟구쳤다."라는 문장이 들어가기에 가장 자연스러운 위치는 어디인가요?',
    'multiple_choice',
    '["[ 1 ]", "[ 2 ]", "[ 3 ]", "들어갈 수 없음"]'::json,
    '[ 1 ]',
    '주가가 시간외 거래에서 6.9% 상승했다는 언급 바로 뒤인 [ 1 ]에 위치하는 것이 문맥상 가장 자연스럽습니다.',
    '주가가 163.50달러까지 오른 직후에 들어갈 문장을 선택하세요.',
    'room',
    'structure',
    'structure_sentence_insertion',
    4
),
-- 20. structure / structure_irrelevant_sentence (multiple_choice)
(
    (SELECT news_id FROM news_articles WHERE title = '오라클, AI 클라우드 3자릿수 성장…대규모 투자 우려에도 장외 주가 반등'),
    '[문단] SW 매출은 55억 5000만 달러로 전년 동기 대비 3% 감소했다. (ㄱ) SW 라이선스 매출은 6억 5500만 달러로 14% 줄었다. (ㄴ) 오라클은 최근 사옥 주변에 대형 공원을 조성하기로 결정했다. (ㄷ) 소프트웨어 지원 매출도 48억 9500만 달러로 1% 감소했다.

[문제] 위 문단에서 흐름상 관계없는 문장은 무엇인가요?',
    'multiple_choice',
    '["(ㄱ)", "(ㄴ)", "(ㄷ)", "없음"]'::json,
    '(ㄴ)',
    '(ㄴ)은 오라클 사옥 근처의 공원 조성에 관한 글로, SW 매출 세부 항목 감소를 다루는 문단의 내용과 관련이 없습니다.',
    '소프트웨어 매출 감소 수치를 설명하는 내용 사이에 들어간 어색한 문장을 찾으세요.',
    'room',
    'structure',
    'structure_irrelevant_sentence',
    4
);
