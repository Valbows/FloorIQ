# FloorIQ - AI-Powered Real Estate Analysis Platform

**Intelligent real estate assistant that transforms floor plans into actionable insights for real estate developers and agents.**

FloorIQ uses advanced AI to parse floor plans, extract detailed room dimensions, enrich property data with comprehensive market insights, and generate predictive pricing models—eliminating months of manual data entry and analysis.

---

## 🎯 What FloorIQ Does

### For Real Estate Developers
- **Automated Floor Plan Analysis**: Extract precise room dimensions (width × length) from any floor plan using Google Gemini Vision AI
- **Bulk Property Analysis**: Analyze entire comp sets (100+ properties) instead of one-by-one manual entry
- **Predictive Pricing Models**: Statistical regression models that correlate room dimensions to Price Per Square Foot (PPSF)
- **Layout Optimization**: Identify which room dimensions maximize property value
- **Time Savings**: Reduce 2-3 months of manual analysis to under 1 day

### For Real Estate Agents
- **Market Insights**: Comprehensive property data from ATTOM API, Zillow, Redfin, and StreetEasy
- **MLS-Ready Listing Copy**: AI-generated professional listing descriptions, headlines, and social media content
- **Interactive Public Reports**: Shareable property reports with floor plans, analytics, and comparable properties
- **Price Predictions**: ML-powered pricing with confidence intervals based on features and location

---

## 🏗️ Architecture

**Tech Stack**:
- **AI/ML**: Google Gemini 2.5 Flash (Vision API for floor plans), CrewAI (agent orchestration)
- **Market Data**: ATTOM API, Bright Data (Zillow/Redfin/StreetEasy scraping)
- **Database**: Supabase (PostgreSQL + Auth + Storage)
- **Backend**: Python Flask + Celery (async task processing)
- **Frontend**: React + Vite + TailwindCSS (mobile-first)
- **Analytics**: scikit-learn, pandas, numpy (regression models)
- **Infrastructure**: Docker + Docker Compose

**AI Agents**:
1. **Floor Plan Analyst**: Extracts room dimensions, layout features, and quality scores
2. **Market Insights Analyst**: Gathers multi-source property data and comparable sales
3. **Listing Copywriter**: Generates MLS-ready copy with tone customization

---

## 🚀 Getting Started

### Prerequisites
- Python 3.11+
- Node.js 18+
- Docker & Docker Compose
- API Keys: ATTOM, Google Gemini, Tavily, Supabase, Bright Data (optional), Google Maps

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd FloorIQ
   ```

2. **Configure environment variables**
   ```bash
   cp .env.example .env
   # Edit .env and add your API keys
   ```

3. **Install dependencies**
   ```bash
   # Backend dependencies
   pip install -r backend/requirements.txt
   
   # Frontend dependencies
   npm install --prefix frontend
   
   # Playwright for web scraping
   playwright install
   ```

4. **Launch with Docker**
   ```bash
   docker-compose up --build
   ```
   
   Services will be available at:
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:5000
   - Redis: localhost:6379

5. **Run tests**
   ```bash
   # Backend tests
   pytest backend/tests/ --cov
   
   # Frontend tests
   npm test --prefix frontend
   
   # E2E tests
   npx playwright test
   ```

---

## 📊 Current Status

**Phase Completion**:
- ✅ Phase 0: Foundation & Authentication
- ✅ Phase 1: Data Ingestion & Core Parsing
- ✅ Phase 2: AI Enrichment & Copywriting
- ✅ Phase 3: Agent Dashboard & API Endpoints
- ✅ Phase 4: Public Reports & Buyer Experience
- ⏳ Phase 5: Deployment & Documentation (In Progress)
- ⏳ Phase 6: Advanced Analytics & Multi-Source Data (In Progress)

**Recent Achievements**:
- ✅ ATTOM-first data pipeline (CoreLogic deprecated)
- ✅ Floor plan measurement estimation with quality scoring
- ✅ Statistical regression models for predictive pricing
- ✅ Multi-source web scraping (Zillow, Redfin, StreetEasy)
- ✅ Interactive public reports with Google Maps integration
- ✅ Analytics dashboard with charts and export to CSV

---

## 📁 Project Structure

```
FloorIQ/
├── backend/
│   ├── app/
│   │   ├── agents/          # AI agents (Floor Plan, Market Insights, Copywriter)
│   │   ├── clients/         # API clients (ATTOM, Bright Data, etc.)
│   │   ├── routes/          # Flask API endpoints
│   │   ├── services/        # Business logic (pricing models, measurements)
│   │   ├── scrapers/        # Web scrapers (Zillow, Redfin, StreetEasy)
│   │   ├── tasks/           # Celery async tasks
│   │   └── utils/           # Utilities (geocoding, Supabase client)
│   ├── tests/               # Unit, integration, and evaluation tests
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   ├── components/      # React components
│   │   ├── pages/           # Dashboard, PropertyDetail, PublicReport
│   │   └── services/        # API client
│   └── package.json
├── database/
│   ├── COMPLETE_SCHEMA_WITH_PHASE1.sql
│   └── migrations/
├── docker/
│   ├── Dockerfile.backend
│   ├── Dockerfile.celery
│   └── Dockerfile.frontend
├── docs/                    # API documentation
├── Client_info/             # Client requirements and reference data
├── docker-compose.yml
├── plan.md                  # Detailed development roadmap
└── log.md                   # Change log
```

---

## 🔑 Key Features

### Floor Plan Analysis
- AI-powered dimension extraction (Google Vision + OCR)
- Room-by-room measurements (living room, bedrooms, kitchen, bathrooms, etc.)
- Floor plan quality scoring (0-100)
- Measurement estimation using standard door/window sizes
- Feature detection (balconies, closets, washer/dryer, etc.)

### Market Insights
- Multi-source property data (ATTOM, Zillow, Redfin, StreetEasy)
- Comparable sales analysis
- AVM (Automated Valuation Model) estimates
- Market trends (appreciation, inventory, demand)
- Investment scoring (1-100)
- Rental income projections

### Predictive Analytics
- Room dimension regression models ("Each 1ft of living room width adds $X/sqft")
- Building amenity impact analysis
- Location factor analysis (proximity to transit, schools, parks)
- Side-by-side property comparison (e.g., 3BR/2BA vs 3BR/1.5BA)
- Predicted price with confidence intervals

### Agent Dashboard
- Property management (upload, edit, delete)
- Status tracking (processing → analyzing → complete)
- Editable listing copy with tone customization
- Analytics (view counts, user agents, charts)
- Shareable link generation with expiration
- CSV export for regression analysis

### Public Reports
- Mobile-responsive property reports
- Interactive floor plan viewer (zoom, pan, fullscreen)
- Comparable properties display
- Google Maps with amenities (schools, shopping, parks)
- No authentication required (shareable token URLs)

---

## 📚 Documentation

- **Development Roadmap**: [`plan.md`](plan.md) - Comprehensive 750-line development plan
- **Change Log**: [`log.md`](log.md) - Track all bug fixes and breaking changes
- **Analytics API**: [`backend/docs/ANALYTICS_API.md`](backend/docs/ANALYTICS_API.md)
- **Client Requirements**: [`Client_info/andrew-requirements-summary.md`](Client_info/andrew-requirements-summary.md)
- **Test Results**: [`CREWAI_TEST_RESULTS.md`](CREWAI_TEST_RESULTS.md)
- **Legacy Documentation**: [`docs/archive/corelogic-legacy/`](docs/archive/corelogic-legacy/)

---

## 🧪 Testing

**Test Coverage**:
- Backend: 90%+ (unit + integration tests)
- Frontend: Component tests with Jest + React Testing Library
- E2E: Playwright tests for critical user flows
- Evaluation: Real-world accuracy testing with manual QA

**Run Tests**:
```bash
# All backend tests
pytest backend/tests/ -v --cov

# Specific test suites
pytest backend/tests/unit/
pytest backend/tests/integration/
pytest backend/tests/evaluation/

# E2E tests
npx playwright test
npx playwright test --ui  # Interactive mode
```

---

## 🛠️ API Endpoints

### Authentication
- `POST /auth/register` - Create new user
- `POST /auth/login` - Login and get JWT token
- `GET /auth/verify` - Verify token validity
- `GET /auth/me` - Get current user profile

### Properties (Protected)
- `GET /api/properties` - List all properties
- `GET /api/properties/<id>` - Get property details
- `POST /api/properties/upload` - Upload floor plan
- `POST /api/properties/search` - Create property by address
- `PUT /api/properties/<id>` - Edit listing copy
- `DELETE /api/properties/<id>` - Delete property

### Analytics (Protected)
- `GET /api/analytics/dashboard` - Dashboard analytics
- `POST /api/analytics/train-model` - Train regression models
- `POST /api/analytics/predict-price` - Predict property price
- `GET /api/properties/<id>/price-impact` - Feature impact analysis

### Public Reports
- `GET /api/public/report/<token>` - Get public report (no auth)
- `POST /api/public/report/<token>/log_view` - Track view

See [`backend/docs/ANALYTICS_API.md`](backend/docs/ANALYTICS_API.md) for full API documentation.

---

## 🤝 Contributing

This is a proprietary project for internal use. Development follows the roadmap in [`plan.md`](plan.md).

**Current Development Branch**: `Val-Branch`

---

## 📄 License

Proprietary – Internal use only. All rights reserved.

---

## 🎯 Roadmap

**Completed**:
- ✅ ATTOM API integration (replaced CoreLogic)
- ✅ CrewAI agent orchestration
- ✅ Floor plan dimension extraction
- ✅ Statistical regression models
- ✅ Multi-source web scraping
- ✅ Public shareable reports

**In Progress**:
- ⏳ Bulk comp set analysis
- ⏳ CSV export for external regression
- ⏳ Production deployment

**Planned**:
- 🔜 Predictive layout optimization ("Expand living room by 50sf → +$200/sqft")
- 🔜 MLS/REMNY integration for auto-pulling floor plans
- 🔜 Market trend forecasting

See [`plan.md`](plan.md) for detailed 120-hour development timeline.

---

**Last Updated**: November 8, 2025  
**Version**: Phase 4 Complete, Phase 5-6 In Progress
