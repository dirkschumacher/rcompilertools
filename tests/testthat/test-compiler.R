test_that("get ops", {
  code <- compiler::compile(quote(1 + 1))
  res <- tidy_bytecode(code)
  expect_true(is.list(res))
  code <- res$code
  expect_true(nrow(code) > 0)
  expect_setequal(colnames(code), c("op_code", "type", "op_code_int"))
})

test_that("eval ops", {
  code <- tidy_bytecode(quote({
    total <- 1
    for (i in seq_len(10)) {
      total <- total + 1
    }
    total
  }))
  res <- eval_code(code)
  expect_equal(res, 11)
})

test_that("get opcodes", {
  codes <- opcodes()
  expect_true(is.data.frame(codes))
  expect_true(nrow(codes) > 100)
})
