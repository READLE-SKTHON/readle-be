ALTER TABLE user_answers
DROP COLUMN answered_at,
    ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT now(),
    ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT now();

ALTER TABLE answer_evaluations
    ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT now(),
    ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT now();

ALTER TABLE user_answers
    ALTER COLUMN selected_answer SET NOT NULL,
ALTER COLUMN result_status SET NOT NULL,
    ALTER COLUMN overall_score SET NOT NULL,
    ALTER COLUMN feedback SET NOT NULL;
