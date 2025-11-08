# AI Floor Plan Insights

This repository has fully migrated from CoreLogic to an ATTOM-first data pipeline.

## Current Status
- ✅ Backend, agents, and Celery tasks use `AttomAPIClient`
- ✅ Market insights enrichment and tests run on ATTOM data only
- ✅ Legacy CoreLogic notes are preserved under [`docs/archive/corelogic-legacy/`](docs/archive/corelogic-legacy/)

## Getting Started
1. Copy `.env.example` to `.env` and add the required API keys (ATTOM, Gemini, Tavily, Supabase, Bright Data).
2. Install dependencies:
   ```bash
   pip install -r backend/requirements.txt
   npm install --prefix frontend
   ```
3. Launch services with Docker:
   ```bash
   docker-compose up --build
   ```
4. Run tests:
   ```bash
   pytest
   npm test --prefix frontend
   ```

## Documentation
- Active development plans will be captured in `plan.md`
- Operations log is tracked in `log.md`
- Legacy materials live in [`docs/archive/corelogic-legacy/`](docs/archive/corelogic-legacy/)

## License
Proprietary – internal use only.
