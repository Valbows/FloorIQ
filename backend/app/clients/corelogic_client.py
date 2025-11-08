"""
CoreLogic integration has been deprecated.

This module remains only to provide a clear runtime error if legacy imports
are still present anywhere in the codebase. All property enrichment now flows
through the ATTOM platform exclusively.
"""

from typing import Any


class CoreLogicClient:  # pragma: no cover - defensive stub
    """Stub client preserving import compatibility after CoreLogic removal."""

    def __init__(self, *args: Any, **kwargs: Any) -> None:
        raise NotImplementedError(
            "CoreLogic integration was removed. Use AttomAPIClient for all market data."
        )
