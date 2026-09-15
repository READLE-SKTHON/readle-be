-- 닉네임이 유저를 유일하게 식별할 수 있도록 유니크 제약
ALTER TABLE users ADD CONSTRAINT uq_users_nickname UNIQUE (nickname);
