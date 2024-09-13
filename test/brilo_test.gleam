import brilo
import gleam/iterator
import gleam/string
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn iterator_from_string_test() {
  let string = "BRILO RULEZ! 🎆"

  string
  |> brilo.iterator_from_string
  |> iterator.to_list
  |> string.join("")
  |> should.equal(string)
}
