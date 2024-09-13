import gleam/iterator.{type Iterator, Done, Next}
import gleam/string

/// Creates an iterator that yields each grapheme from the given string.
///
/// ## Examples
///
/// ```gleam
/// iterator_from_string("abcd")
/// |> to_list
/// // -> ["a", "b", "c", "d"]
/// ```
///
pub fn iterator_from_string(string: String) -> Iterator(String) {
  let yield = fn(s) {
    case s |> string.pop_grapheme {
      Ok(#(x, xs)) -> Next(x, xs)
      _ -> Done
    }
  }

  iterator.unfold(from: string, with: yield)
}

/// Returns an iterator of sliding windows.
///
/// ## Examples
///
/// ```gleam
/// iterator.from_list([1,2,3,4,5])
///   |> iterator_window(3)
///   |> iterator.map(iterator.to_list)
///   |> iterator.to_list
/// // -> [[1, 2, 3], [2, 3, 4], [3, 4, 5]]
/// ```
///
/// ```gleam
/// window([1, 2], 4)
/// // -> []
/// ```
///
pub fn iterator_window(i: Iterator(a), by n: Int) -> Iterator(Iterator(a)) {
  let yield = fn(x: Iterator(a)) {
    let chunk = x |> iterator.take(n)

    case chunk |> iterator.length == n {
      True -> Next(chunk, x |> iterator.drop(1))
      False -> Done
    }
  }

  iterator.unfold(from: i, with: yield)
}

/// Returns an iterator of tuples containing two contiguous elements.
///
/// ## Examples
///
/// ```gleam
/// iterator_window_by_2([1,2,3,4])
///   |> iterator.to_list
/// // -> [#(1, 2), #(2, 3), #(3, 4)]
/// ```
///
/// ```gleam
/// iterator_window_by_2([1])
///   |> iterator.to_list
/// // -> []
/// ```
///
pub fn iterator_window_by_2(i: Iterator(a)) -> Iterator(#(a, a)) {
  iterator.zip(i, iterator.drop(i, 1))
}
