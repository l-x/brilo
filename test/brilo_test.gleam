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

pub fn iterator_window_test() {
  [1, 2, 3, 4, 5]
  |> iterator.from_list
  |> brilo.iterator_window(2)
  |> iterator.map(iterator.to_list)
  |> iterator.to_list
  |> should.equal([[1, 2], [2, 3], [3, 4], [4, 5]])
}

pub fn iterator_window_empty_test() {
  iterator.empty()
  |> brilo.iterator_window(2)
  |> iterator.map(iterator.to_list)
  |> iterator.to_list
  |> should.equal([])
}

pub fn iterator_window_one_size_test() {
  [1, 2, 3, 4, 5]
  |> iterator.from_list
  |> brilo.iterator_window(1)
  |> iterator.map(iterator.to_list)
  |> iterator.to_list
  |> should.equal([[1], [2], [3], [4], [5]])
}

pub fn iterator_window_full_size_test() {
  [1, 2, 3, 4, 5]
  |> iterator.from_list
  |> brilo.iterator_window(5)
  |> iterator.map(iterator.to_list)
  |> iterator.to_list
  |> should.equal([[1, 2, 3, 4, 5]])
}

pub fn iterator_window_over_size_test() {
  [1, 2, 3, 4, 5]
  |> iterator.from_list
  |> brilo.iterator_window(6)
  |> iterator.map(iterator.to_list)
  |> iterator.to_list
  |> should.equal([])
}

pub fn iterator_window_by_2_test() {
  [1, 2, 3, 4, 5]
  |> iterator.from_list
  |> brilo.iterator_window_by_2
  |> iterator.to_list
  |> should.equal([#(1, 2), #(2, 3), #(3, 4), #(4, 5)])
}

pub fn iterator_window_by_2_empty_test() {
  iterator.empty()
  |> brilo.iterator_window_by_2
  |> iterator.to_list
  |> should.equal([])
}

pub fn iterator_window_by_2_full_size_test() {
  [1, 2]
  |> iterator.from_list
  |> brilo.iterator_window_by_2
  |> iterator.to_list
  |> should.equal([#(1, 2)])
}

pub fn iterator_window_by_2_over_size_test() {
  [1]
  |> iterator.from_list
  |> brilo.iterator_window_by_2
  |> iterator.to_list
  |> should.equal([])
}

pub fn string_translate_none_test() {
  "ABCDE"
  |> brilo.string_translate([#("X", "Y")])
  |> should.equal("ABCDE")
}

pub fn string_translate_empty_test() {
  ""
  |> brilo.string_translate([#("X", "Y")])
  |> should.equal("")
}

pub fn string_translate_no_translations_test() {
  "ABCDE"
  |> brilo.string_translate([])
  |> should.equal("ABCDE")
}

pub fn string_translate_one_test() {
  "ABCDE"
  |> brilo.string_translate([#("C", "X")])
  |> should.equal("ABXDE")
}

pub fn string_translate_in_order_test() {
  "ABCDE"
  |> brilo.string_translate([#("B", ""), #("D", "A"), #("E", "B")])
  |> should.equal("ACAB")
}
