render_book_slides <- function(...) {
  quarto::quarto_render(..., as_job = FALSE)
  file.rename("_quarto.yml", "_quarto_site.yml")
  file.rename("_quarto_revealjs.yml", "_quarto.yml")
  on.exit(file.rename("_quarto.yml", "_quarto_revealjs.yml"))
  on.exit(file.rename("_quarto_site.yml", "_quarto.yml"), add = TRUE)
  quarto::quarto_render(..., as_job = FALSE)
}