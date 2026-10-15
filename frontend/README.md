# Frontend

React + TypeScript + Vite + Tailwind CSS + TanStack Query. Scaffold in Week 3:

```bash
npm create vite@latest . -- --template react-ts
npm install tailwindcss @tailwindcss/vite @tanstack/react-query react-router-dom
```

Planned layout:

```
src/
├── api/          typed API client (one file per backend feature)
├── components/   reusable UI pieces
├── pages/        Home, Projects, ProjectDetail, Contact, Admin
├── hooks/        data hooks built on TanStack Query
└── types/        shared TypeScript types mirroring backend DTOs
```

Rules: TypeScript strict mode, ESLint + Prettier, every data call has loading, error and empty states.
