#' Obtain the OP codes of compiled bytecode
#' @param bcode bytecode or something that can be compiled to byte code
#' @export
opcode_table <- function(bcode) {
  bcode <- ensure_bytecode(bcode)
  info <- disassemble_code(bcode)
  ops <- vapply(info[[2L]], as.character, character(1L))
  types <- classify_ops(ops)
  data.frame(
    op_code = ops,
    type = types,
    stringsAsFactors = FALSE
  )
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
  if (!("bytecode" %in% class(code))) {
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
  types <- rep.int("OP", length(opcodes))
  types[!is.na(indexes)] <- "INDEX_OR_LABEL"
  types
}
