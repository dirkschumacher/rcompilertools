test_that("get ops", {
  code <- compiler::compile(quote(1 + 1))
  res <- opcode_table(code)
  expect_true(is.data.frame(res))
  expect_true(nrow(res) > 0)
  expect_equal(colnames(res), c("op_code", "type"))
})

test_that("get opcodes", {
  codes <- opcodes()
  expect_true(is.data.frame(codes))
  expect_true(nrow(codes) > 100)
})
