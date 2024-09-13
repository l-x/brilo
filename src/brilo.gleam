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
