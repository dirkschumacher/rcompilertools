#' Obtain the OP codes of compiled bytecode
#' @param bcode bytecode or something that can be compiled to byte code
#' @export
tidy_bytecode <- function(bcode) {
  bcode <- ensure_bytecode(bcode)
  info <- disassemble_code(bcode)
  ops <- vapply(info[[2L]], as.character, character(1L))
  codes <- opcodes()
  ops_int <- as.integer(codes$code[match(ops, codes$name)])
  ops_int[is.na(ops_int)] <- as.integer(ops[is.na(ops_int)])
  const_pool <- as.list(info[[3]])
  types <- classify_ops(ops)
  structure(
    list(
      code = data.frame(
        op_code = ops,
        op_code_int = ops_int,
        type = types,
        stringsAsFactors = FALSE
      ),
      constant_pool = const_pool
    ), class = "tidy_bytecode"
  )
}

#' Eval tidy bytecode
#'
#' @param x an object of class tidy_bytecode
#'
#' @export
eval_code <- function(x) {
  stopifnot(inherits(x, "tidy_bytecode"))
  ops <- x$code$op_code_int
  constant_pool <- x$constant_pool
  bc <- .Internal(mkCode(ops, constant_pool))
  eval(bc)
}

#' A data.frame of all OP codes
#' @export
opcodes <- function() {
  res <- data.frame(
    name = compiler:::Opcodes.names,
    args = as.integer(compiler:::Opcodes.argc[compiler:::Opcodes.names]),
    stringsAsFactors = FALSE
  )
  cmp_ns <- getNamespace("compiler")
  res$code <- vapply(res$name, function(name) {
    as.integer(cmp_ns[[name]])
  }, integer(1L))
  res
}

ensure_bytecode <- function(code) {
  if (!inherits(code, "bytecode")) {
    code <- compiler::compile(code)
  }
  code
}

disassemble_code <- function(bcode) {
  utils::capture.output(info <- compiler::disassemble(bcode))
  info
}

classify_ops <- function(opcodes) {
  indexes <- suppressWarnings(as.integer(opcodes))
  types <- rep.int("OPERATOR", length(opcodes))
  types[!is.na(indexes)] <- "OPERAND"
  types
}
