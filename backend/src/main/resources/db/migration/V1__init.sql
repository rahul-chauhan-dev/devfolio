-- V1__init.sql : initial schema for DevFolio
-- Conventions: snake_case, BIGINT identity keys, TIMESTAMPTZ for all timestamps.

CREATE TABLE admin_user (
    id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email          VARCHAR(255) NOT NULL,
    password_hash  VARCHAR(100) NOT NULL,           -- BCrypt hash, never plain text
    display_name   VARCHAR(100) NOT NULL,
    role           VARCHAR(20)  NOT NULL DEFAULT 'ADMIN',
    created_at     TIMESTAMPTZ  NOT NULL DEFAULT now(),
    last_login_at  TIMESTAMPTZ,
    CONSTRAINT uq_admin_user_email UNIQUE (email),
    CONSTRAINT ck_admin_user_role CHECK (role IN ('ADMIN'))
);

CREATE TABLE project (
    id               BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    slug             VARCHAR(120) NOT NULL,          -- URL-friendly id, e.g. "devfolio"
    title            VARCHAR(150) NOT NULL,
    summary          VARCHAR(500) NOT NULL,          -- one-liner shown on cards
    case_study_md    TEXT,                           -- Markdown: problem, architecture, trade-offs
    repo_url         VARCHAR(500),
    live_url         VARCHAR(500),
    cover_image_url  VARCHAR(500),
    status           VARCHAR(20)  NOT NULL DEFAULT 'DRAFT',
    featured         BOOLEAN      NOT NULL DEFAULT FALSE,
    display_order    INTEGER      NOT NULL DEFAULT 0,
    started_on       DATE,
    created_at       TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at       TIMESTAMPTZ  NOT NULL DEFAULT now(),
    version          BIGINT       NOT NULL DEFAULT 0, -- optimistic locking (@Version)
    CONSTRAINT uq_project_slug UNIQUE (slug),
    CONSTRAINT ck_project_slug_format CHECK (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$'),
    CONSTRAINT ck_project_status CHECK (status IN ('DRAFT', 'PUBLISHED', 'ARCHIVED'))
);

CREATE INDEX idx_project_status_order ON project (status, display_order);

CREATE TABLE skill (
    id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name           VARCHAR(80)  NOT NULL,
    category       VARCHAR(30)  NOT NULL,
    proficiency    SMALLINT     NOT NULL DEFAULT 3,
    icon           VARCHAR(100),
    display_order  INTEGER      NOT NULL DEFAULT 0,
    CONSTRAINT uq_skill_name UNIQUE (name),
    CONSTRAINT ck_skill_category CHECK (category IN
        ('LANGUAGE', 'BACKEND', 'FRONTEND', 'DATABASE', 'DEVOPS', 'TESTING', 'TOOL')),
    CONSTRAINT ck_skill_proficiency CHECK (proficiency BETWEEN 1 AND 5)
);

-- Many-to-many: a project uses many skills, a skill is used by many projects.
CREATE TABLE project_skill (
    project_id  BIGINT NOT NULL,
    skill_id    BIGINT NOT NULL,
    PRIMARY KEY (project_id, skill_id),
    CONSTRAINT fk_project_skill_project FOREIGN KEY (project_id) REFERENCES project (id) ON DELETE CASCADE,
    CONSTRAINT fk_project_skill_skill   FOREIGN KEY (skill_id)   REFERENCES skill (id)   ON DELETE CASCADE
);

CREATE INDEX idx_project_skill_skill ON project_skill (skill_id);

CREATE TABLE contact_message (
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name        VARCHAR(100)  NOT NULL,
    email       VARCHAR(255)  NOT NULL,
    subject     VARCHAR(150),
    message     VARCHAR(5000) NOT NULL,
    status      VARCHAR(20)   NOT NULL DEFAULT 'NEW',
    ip_hash     CHAR(64),                            -- SHA-256 of IP + salt, for rate limiting/abuse only
    created_at  TIMESTAMPTZ   NOT NULL DEFAULT now(),
    CONSTRAINT ck_contact_message_status CHECK (status IN ('NEW', 'READ', 'ARCHIVED'))
);

CREATE INDEX idx_contact_message_status_created ON contact_message (status, created_at DESC);

-- Note: no admin user is seeded here. Create it at startup from environment variables
-- (Week 4) so no credentials ever live in Git.
