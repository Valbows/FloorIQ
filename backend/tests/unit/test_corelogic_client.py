"""CoreLogic client has been removed; ensure stubs raise informative errors."""

import pytest

from app.clients.corelogic_client import CoreLogicClient


def test_corelogic_client_removed():
    with pytest.raises(NotImplementedError):
        CoreLogicClient()
