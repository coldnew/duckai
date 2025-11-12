# Agent Instructions for DuckAI OpenAI Server

## Build/Lint/Test Commands

### Development
- `npm run dev` - Start development server with hot reload
- `npm start` - Start production server

### Testing
- `npm test` - Run all tests once
- `npm run test:watch` - Run tests in watch mode
- `npm run test:openai` - Run basic OpenAI tests
- `npm run test:openai-full` - Run comprehensive OpenAI tests
- `npm run test:tools` - Run tool/function calling tests
- `npm run test:e2e` - Run end-to-end tests
- `npm run test:all` - Run all test suites

### Single Test Execution
Run a specific test file: `npx vitest run tests/<filename>.test.ts`

## Code Style Guidelines

### Imports
- Use ES6 imports with named imports
- Group imports: Node.js built-ins, external packages, then local modules
- Use type imports for TypeScript types: `import type { Interface } from './types'`
- One import per line for clarity

### Formatting
- 2-space indentation
- No semicolons
- Single quotes for strings
- Trailing commas in multi-line objects/arrays

### Types
- Strict TypeScript with explicit types
- Use interfaces for object shapes
- Define return types for all functions
- Use union types for variants (`"stop" | "length" | null`)

### Naming Conventions
- camelCase for variables, functions, and methods
- PascalCase for classes, interfaces, and types
- UPPER_CASE for constants
- Descriptive, meaningful names (avoid abbreviations)

### Error Handling
- Use try-catch blocks for async operations
- Throw Error objects with descriptive messages
- Validate inputs early with clear error messages
- Return appropriate HTTP status codes (400 for validation, 500 for server errors)

### Code Structure
- Use arrow functions for callbacks and short functions
- Async/await over Promises
- Early returns for error conditions
- Destructure objects for cleaner code
- Use const by default, let only when reassignment needed