"""Sorting algorithm exercises in Python 3.

Each function below describes a small practice task. Replace the
``raise NotImplementedError`` statements with your own implementation to
complete the exercise. The goal is to build familiarity with common
sorting techniques, their trade-offs, and the idea of writing helper
functions and tests.

All functions are expected to leave the input data untouched unless the
docstring explicitly says otherwise. You may use additional helper
functions if that keeps your solution clean and easy to understand.
"""

from __future__ import annotations

from typing import Iterable, List, Sequence, Tuple, TypeVar


T = TypeVar("T")


def bubble_sort(values: Sequence[T]) -> List[T]:
    """Return a new list containing ``values`` sorted using bubble sort.

    Exercise goals:
      * Implement the nested-loop bubble sort algorithm.
      * Ensure the original ``values`` sequence is not modified.
      * Stop early if the sequence becomes sorted before all passes finish.

    The function should support any sequence of orderable items
    (e.g. ``List[int]``, ``Tuple[str, ...]``).
    """

    raise NotImplementedError("Implement the bubble sort exercise")


def selection_sort(values: Sequence[T]) -> List[T]:
    """Return a new list containing ``values`` sorted via selection sort.

    Exercise goals:
      * Iterate through the sequence, selecting the smallest remaining item.
      * Build up the sorted portion of the list one element at a time.
      * Do not mutate the incoming ``values`` sequence.
    """

    raise NotImplementedError("Implement the selection sort exercise")


def insertion_sort_in_place(values: List[T]) -> None:
    """Sort ``values`` in place using insertion sort.

    Exercise goals:
      * Work directly on the input list without returning a new one.
      * Shift elements to make room for the current element, like sorting
        playing cards in hand.
      * Keep the algorithm stable (equal values remain in their original
        relative order).
    """

    raise NotImplementedError("Implement the insertion sort (in place) exercise")


def merge(left: Sequence[T], right: Sequence[T]) -> List[T]:
    """Merge two already-sorted sequences into a new sorted list.

    Exercise goals:
      * Walk through both sequences simultaneously, always picking the
        smaller of the available front elements.
      * Return a fresh list, leaving ``left`` and ``right`` unchanged.
      * Maintain stability: preserve the ordering of equal elements from
        the original sequences.
    """

    raise NotImplementedError("Implement the merge helper exercise")


def merge_sort(values: Sequence[T]) -> List[T]:
    """Return a new list containing ``values`` sorted using merge sort.

    Exercise goals:
      * Use the ``merge`` helper defined above to combine sorted halves.
      * Recurse until a base case of length 0 or 1 is reached.
      * Avoid mutating the ``values`` sequence provided by the caller.
    """

    raise NotImplementedError("Implement the merge sort exercise")


def count_comparisons(algorithm, values: Sequence[T]) -> Tuple[List[T], int]:
    """Run ``algorithm`` on ``values`` and count comparison operations.

    ``algorithm`` should be a callable that accepts a sequence and returns a
    new sorted list. The exercise is to wrap the algorithm so that it can
    report how many comparisons were performed while sorting.

    Exercise goals:
      * Accept any sorting function with the signature ``(Sequence[T]) -> List[T]``.
      * Return a tuple ``(sorted_values, comparisons)``.
      * Teach how decorators or higher-order functions can add instrumentation.

    Hint: consider writing a helper class that proxies element comparisons.
    """

    raise NotImplementedError("Implement the comparison counting exercise")


def is_sorted(values: Iterable[T]) -> bool:
    """Return ``True`` if ``values`` is sorted in non-decreasing order.

    Exercise goals:
      * Offer an easy way to check your work while experimenting.
      * Work with any iterable without exhausting it prematurely (a single
        pass solution is recommended).
    """

    raise NotImplementedError("Implement the is_sorted helper exercise")


__all__ = [
    "bubble_sort",
    "selection_sort",
    "insertion_sort_in_place",
    "merge",
    "merge_sort",
    "count_comparisons",
    "is_sorted",
]
