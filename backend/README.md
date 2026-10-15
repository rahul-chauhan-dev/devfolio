# Backend

Spring Boot (Java 21) REST API. Generate the project in Week 2 from https://start.spring.io with:

- Dependencies: Spring Web, Validation, Spring Data JPA, Spring Security, Actuator, PostgreSQL Driver, Flyway Migration, Testcontainers
- Group: `com.<yourname>`, Artifact: `devfolio`, Packaging: Jar

Planned package layout (feature-based, not layer-based):

```
com.<you>.devfolio
├── project/    controller, service, repository, dto, entity
├── skill/
├── github/
├── contact/
├── auth/
└── common/     exception handler, config, security
```

Database migrations live in `src/main/resources/db/migration` (Flyway). The first one, `V1__init.sql`, is already written.
