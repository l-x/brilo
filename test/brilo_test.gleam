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

pub fn window_test() {
  let testcase = fn(subject, n, expected) {
    subject
    |> iterator.from_list
    |> brilo.iterator_window(n)
    |> iterator.map(iterator.to_list)
    |> iterator.to_list
    |> should.equal(expected)
  }

  testcase([1, 2, 3], 2, [[1, 2], [2, 3]])
  testcase([1, 2, 3], 3, [[1, 2, 3]])
  testcase([1, 2, 3], 4, [])
  testcase([1, 2, 3, 4, 5], 3, [[1, 2, 3], [2, 3, 4], [3, 4, 5]])
  testcase([1, 2, 3], 0, [])
  testcase([1, 2, 3], -1, [])
}

pub fn window_by_2_test() {
  let testcase = fn(subject, expected) {
    subject
    |> iterator.from_list
    |> brilo.iterator_window_by_2
    |> iterator.to_list
    |> should.equal(expected)
  }

  testcase([1, 2, 3, 4], [#(1, 2), #(2, 3), #(3, 4)])
  testcase([1], [])
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
