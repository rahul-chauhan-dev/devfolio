# ADR 0001: Modular monolith instead of microservices

- **Status:** Accepted
- **Date:** 2026-10-11

## Context

DevFolio has five small features, one developer, and a free-tier hosting budget. It needs to be easy to run, test and deploy.

## Decision

Build a single Spring Boot application organised by feature packages, backed by one PostgreSQL database.

## Consequences

- Positive: one deployable, simple local setup (`docker compose up`), easy transactions, fast to test, cheap to host.
- Positive: feature packages keep boundaries clear, so a feature could be extracted later if ever needed.
- Negative: all features scale together. Acceptable for portfolio-level traffic.

## Alternatives considered

- **Microservices:** operational overhead (networking, tracing, deployment) with no benefit at this size.
- **Serverless functions:** cold starts and awkward fit for Spring Boot and JPA.
