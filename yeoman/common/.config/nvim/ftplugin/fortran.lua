local extension = vim.fn.expand("%:e"):lower()

if extension == "f90" or extension == "f95" or extension == "f03" or extension == "f08" then
  vim.b.fortran_free_source = 1
  vim.b.fortran_fixed_source = nil
else
  vim.b.fortran_fixed_source = 1
  vim.b.fortran_free_source = nil
end

vim.opt_local.expandtab = false
vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = "73"

vim.bo.commentstring = "! %s"
