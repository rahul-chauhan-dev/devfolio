# Wireframes

Low-fidelity layouts for three pages. Recreate these in Figma or Excalidraw later; the structure and reasoning matter more than the boxes.

**Design principles**
- A recruiter should understand who you are and see proof within 10 seconds.
- Projects are the hero. Everything else supports them.
- Mobile-first: design the phone layout, then widen it.
- Every page has one clear primary action.

---

## 1. Home (desktop, 1200px)

```
+--------------------------------------------------------------------------+
| [Logo: YourName]        Projects   Skills   About   Contact   [Sun/Moon] |
+--------------------------------------------------------------------------+
|                                                                          |
|   Hi, I'm <Your Name>.                                +------------+     |
|   Full Stack Java Developer                           |            |     |
|   I build secure, tested REST APIs with Spring Boot   |   Photo /  |     |
|   and React front ends.                               |   avatar   |     |
|                                                       |            |     |
|   [ View Projects ]   [ Download Resume ]             +------------+     |
|   GitHub  LinkedIn  Email                                                |
|                                                                          |
+--------------------------------------------------------------------------+
|  FEATURED PROJECTS                                       [ See all -> ]  |
|  +----------------+  +----------------+  +----------------+              |
|  | [cover image]  |  | [cover image]  |  | [cover image]  |              |
|  | DevFolio       |  | Project 2      |  | Project 3      |              |
|  | One-line pitch |  | One-line pitch |  | One-line pitch |              |
|  | Java Spring PG |  | Java React     |  | Java MySQL     |              |
|  +----------------+  +----------------+  +----------------+              |
+--------------------------------------------------------------------------+
|  TECH I USE                                                              |
|  Backend: Java, Spring Boot, JPA      Frontend: React, TypeScript        |
|  Data: PostgreSQL, Flyway             DevOps: Docker, GitHub Actions     |
+--------------------------------------------------------------------------+
|  LIVE FROM GITHUB   (cached by my API)                                   |
|  Public repos: 12   Recent commit: "feat: add admin CRUD" (2 days ago)   |
+--------------------------------------------------------------------------+
|  GET IN TOUCH:  short message + [ Contact me ]                           |
+--------------------------------------------------------------------------+
| (c) 2026 YourName   |  Status: all systems up  |  Source on GitHub       |
+--------------------------------------------------------------------------+
```

**Why:** the hero gives identity, role and two actions. Featured projects come before skills because proof beats claims. The GitHub block and the footer status link are the differentiators (live API data, observability).

**Mobile:** single column; nav collapses to a hamburger; hero text first, photo below; project cards stacked.

---

## 2. Projects list (desktop)

```
+--------------------------------------------------------------------------+
| [Logo]                  Projects   Skills   About   Contact   [Sun/Moon] |
+--------------------------------------------------------------------------+
|  Projects                                                                |
|  Things I've built and what I learned from each.                         |
|                                                                          |
|  Filter by skill:  (All) (Java) (Spring Boot) (React) (PostgreSQL) ...   |
|  Sort: [ Featured v ]                          Search: [______________]  |
|                                                                          |
|  +---------------------------+   +---------------------------+           |
|  | [cover image]             |   | [cover image]             |           |
|  | DevFolio       [Featured] |   | Library Management        |           |
|  | Portfolio platform with   |   | Spring MVC app with       |           |
|  | CMS, CI/CD, monitoring.   |   | role-based access.        |           |
|  | [Java][Spring][PG][Docker]|   | [Java][Spring][MySQL]     |           |
|  | [Live demo]  [GitHub]     |   | [Live demo]  [GitHub]     |           |
|  +---------------------------+   +---------------------------+           |
|  +---------------------------+   +---------------------------+           |
|  | ...                       |   | ...                       |           |
|  +---------------------------+   +---------------------------+           |
|                                                                          |
|  [ < Prev ]   Page 1 of 2   [ Next > ]                                   |
+--------------------------------------------------------------------------+
|  footer                                                                  |
+--------------------------------------------------------------------------+
```

**States to design:** loading (skeleton cards), empty ("No projects match this filter" plus a reset button), error (message plus retry).

**Backend link:** `GET /api/v1/projects?skill=java&page=0&size=6&sort=displayOrder`. Skill chips come from `GET /api/v1/skills`.

**Mobile:** cards stack in one column; filters become a horizontally scrollable chip row.

---

## 3. Project detail (desktop)

```
+--------------------------------------------------------------------------+
| [Logo]                  Projects   Skills   About   Contact   [Sun/Moon] |
+--------------------------------------------------------------------------+
|  < Back to projects                                                      |
|                                                                          |
|  DevFolio                                                                |
|  Full-stack portfolio platform with CMS, CI/CD and monitoring            |
|  [Live demo]  [Source on GitHub]       Status: PUBLISHED | Started Aug 26 |
|                                                                          |
|  +--------------------------------------------------------------------+  |
|  |                   hero screenshot / cover image                    |  |
|  +--------------------------------------------------------------------+  |
|                                                                          |
|  +--------------------------------------+  +-----------------------+     |
|  | CASE STUDY (rendered Markdown)       |  | TECH USED             |     |
|  |  ## The problem                      |  | [Java 21] [Spring]    |     |
|  |  ## Architecture                     |  | [PostgreSQL] [Docker] |     |
|  |     [ Mermaid diagram ]              |  | [React] [TypeScript]  |     |
|  |  ## Key decisions and trade-offs     |  +-----------------------+     |
|  |  ## Challenges and what I learned    |  | LIVE REPO STATS       |     |
|  |  ## What I would improve next        |  | Stars 3  Commits 120  |     |
|  |                                      |  | Last push: 2 days ago |     |
|  +--------------------------------------+  +-----------------------+     |
|                                                                          |
|  MORE PROJECTS:  [card]  [card]                                          |
+--------------------------------------------------------------------------+
```

**Why:** interviewers read the case study to judge how you think. The sidebar gives quick facts. Repo stats come from the cached GitHub endpoint.

**Backend link:** `GET /api/v1/projects/{slug}` returns the project DTO with skills and `caseStudyMd`.

**Mobile:** the sidebar blocks move below the title and above the case study; Mermaid diagrams scroll horizontally.

---

## What to do next with these

1. Redraw each page on paper or in Figma, and note one change you would make and why.
2. Check each page against the schema: every piece of data shown above should map to a column in [db-schema.md](db-schema.md) or an API in [architecture.md](architecture.md).
