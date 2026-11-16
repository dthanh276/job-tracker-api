CREATE TABLE companies(
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE applications(
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_id INTEGER NOT NULL,
    role TEXT NOT NULL,
    status TEXT NOT NULL
        check(status in('applied','interview','rejected')),

    FOREIGN KEY (company_id)
    REFERENCES companies(id)
);

CREATE TABLE notes(
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    application_id INTEGER NOT NULL,
    content TEXT NOT NULL,

    FOREIGN KEY (application_id)
    REFERENCES applications(id)
);