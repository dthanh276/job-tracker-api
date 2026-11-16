erDiagram
    companies ||..o{ applications : has
    applications ||..o{ notes : has

    companies{
        int id PK
        string name UK 
    }

    applications{
        int id PK
        int company_id FK
        string role
        string status
    }

    notes{
        int id PK
        int application_id FK
        string content
    }