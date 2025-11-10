"""Local replacement for crewai_tools.tool decorator.

Provides a minimal decorator that preserves the function signature while
attaching simple metadata for CrewAI tooling. This avoids pulling in the
full `crewai-tools` package, which conflicts with pinned LangChain versions
on Render deployments.
"""
from __future__ import annotations

from typing import Any, Callable, TypeVar, overload

F = TypeVar("F", bound=Callable[..., Any])


@overload
def tool(name: str) -> Callable[[F], F]:
    ...


@overload
def tool(func: F) -> F:
    ...


def tool(arg: Any) -> Any:
    """Decorator used by CrewAI to register tools.

    Supports both ``@tool`` and ``@tool("Custom Name")`` syntaxes. The
    decorator simply adds ``tool_name`` metadata so CrewAI can discover the
    function without depending on `crewai-tools`.
    """

    def _decorate(func: F) -> F:
        setattr(func, "tool_name", name)
        return func

    if callable(arg):
        name = getattr(arg, "__name__", "anonymous_tool").replace("_", " ").title()
        return _decorate(arg)

    name = str(arg)

    def wrapper(func: F) -> F:
        return _decorate(func)

    return wrapper
