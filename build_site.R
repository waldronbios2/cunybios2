#!/usr/bin/env Rscript

# Ensure LaTeX binaries and packages are available for beamer rendering
tlmgr_bin <- Sys.which("tlmgr")
if (tlmgr_bin == "") {
  candidates <- c(
    "/usr/local/texlive/bin/linux/tlmgr",
    Sys.glob("/usr/local/texlive/bin/*/tlmgr"),
    Sys.glob("/opt/TinyTeX/bin/*/tlmgr"),
    Sys.glob("~/.TinyTeX/bin/*/tlmgr"),
    Sys.glob("~/Library/TinyTeX/bin/*/tlmgr")
  )
  candidates <- candidates[file.exists(candidates)]
  if (length(candidates) > 0) {
    tlmgr_bin <- candidates[1]
    Sys.setenv(PATH = paste(dirname(tlmgr_bin), Sys.getenv("PATH"), sep = ":"))
  }
}

if (tlmgr_bin != "") {
  message("Found tlmgr at: ", tlmgr_bin)
  tex_pkgs <- c(
    "beamer", "pgf", "translator", "booktabs",
    "collection-latexrecommended", "collection-fontsrecommended",
    "xltabular", "ltablex", "multirow", "makecell", "wrapfig", "tabu",
    "threeparttable", "threeparttablex", "colortbl", "pdflscape", "dcolumn",
    "environ", "trimspaces", "collection-latexextra"
  )
  repo <- "https://mirror.math.princeton.edu/pub/CTAN/systems/texlive/tlnet"
  message("Ensuring LaTeX packages are installed via ", repo, ": ", paste(tex_pkgs, collapse = ", "))
  res <- system2(tlmgr_bin, c("--verify-repo=none", "install", "--repository", repo, tex_pkgs), stdout = TRUE, stderr = TRUE)
  message(paste(res, collapse = "\n"))
}

# Ensure docs output directory exists
dir.create("docs", showWarnings = FALSE, recursive = TRUE)
dest_root <- normalizePath("docs", mustWork = TRUE)

message("=== Building main pkgdown site ===")
pkgdown::build_site(override = list(destination = dest_root), preview = FALSE)

# Build pkgdown sites and lecture PDFs for each session
for (i in 1:10) {
  session_name <- paste0("session", i)
  session_dest <- file.path(dest_root, session_name)
  articles_dest <- file.path(session_dest, "articles")

  message(sprintf("=== Building %s pkgdown site ===", session_name))
  pkgdown::build_site(
    pkg = session_name,
    override = list(destination = session_dest),
    preview = FALSE
  )

  lecture_rmd <- file.path(session_name, "vignettes", "session_lecture.Rmd")
  if (file.exists(lecture_rmd)) {
    message(sprintf("=== Rendering %s Lecture PDF ===", session_name))
    dir.create(articles_dest, showWarnings = FALSE, recursive = TRUE)
    rmarkdown::render(
      input = lecture_rmd,
      output_format = "beamer_presentation",
      output_file = "session_lecture.pdf",
      output_dir = articles_dest,
      clean = TRUE,
      quiet = TRUE
    )
  }
}

# Preserve custom domain for GitHub Pages
writeLines("bios2.waldronlab.io", file.path(dest_root, "CNAME"))
message("=== Successfully built site and lecture PDFs for all sessions ===")
