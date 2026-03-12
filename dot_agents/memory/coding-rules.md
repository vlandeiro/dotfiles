# Coding Rules

Universal principles for writing maintainable code.

## Working Approach

- Read files before proposing changes
- Prefer editing existing files over creating new ones
- Don't refactor, add comments, or improve beyond scope
- Keep solutions simple and focused

## Clarity Over Cleverness

- Write code for humans first, compilers second
- Use meaningful variable and function names
- Keep functions focused and single-purpose
- Avoid nested logic deeper than 2-3 levels

## Testing and Validation

- Validate at system boundaries (user input, external APIs)
- Trust internal code and framework guarantees
- Write tests for behavior, not implementation
- Avoid over-testing private implementation details

## No Over-Engineering

- Solve the problem at hand, not hypothetical future problems
- Don't create abstractions for one-time operations
- Don't add features that aren't requested
- Three similar lines of code are better than a premature abstraction

## Documentation

- Write code that is self-documenting
- Add comments only where intent isn't obvious
- Update documentation when behavior changes
- Keep comments accurate and in sync with code
